# GNOME RDP Existing Desktop With Automatic Login on Ubuntu 24.04

## Result

This playbook makes native GNOME RDP control the desktop that is already open
on an automatically logged-in Ubuntu 24.04 machine.

The verified setup was:

| Role | Host | Address at setup time | User |
| --- | --- | --- | --- |
| Remmina and SSH client | `OptiPlex-7090` | `192.168.1.227` | `lachlan` |
| Ubuntu desktop target | `OptiPlex-3040` | `192.168.1.209` | `malab` |

The target exposes two different native GNOME RDP paths:

| Port | GNOME mode | Use |
| --- | --- | --- |
| `3390` | user Desktop Sharing | Primary: control the existing desktop |
| `3389` | system Remote Login | Fallback: GDM without a local session conflict |

The working client address is:

```text
OptiPlex-3040.local:3390
```

The RDP and operating-system passwords are intentionally not recorded here.

## Verified Live State

The final audit on the 3040 showed:

```text
Desktop Sharing: active, enabled, port 3390
View-only: no
Negotiate port: no
Desktop Sharing credentials: hidden
System Remote Login: active, enabled, port 3389
SSH socket: active, enabled, port 22
Avahi: active, enabled
Credential loader: active, enabled
UFW: inactive
```

Remmina established a live connection from `192.168.1.227` to
`192.168.1.209:3390`. The session displayed the existing desktop and accepted
both pointer and keyboard input. A keyring-daemon restart then cleared the
volatile credential as expected; the loader restored it and restarted Desktop
Sharing successfully.

A full machine reboot was not performed because the workstation was in use. The
service enablement and equivalent keyring/session recovery path were verified.

## Why Port 3389 Was Not Enough

GNOME 46 has two RDP services with different session semantics.

System Remote Login on `3389` authenticated correctly and displayed GDM. After
the operating-system password was entered, GDM reported:

```text
Session Already Running
Remote login is not possible because a local session is already running for malab.
```

Forcing that session to stop would close the automatically logged-in desktop and
could lose work. Remote Login is therefore a fallback, not the primary path for
this machine.

User Desktop Sharing can attach to the existing desktop, but its RDP credential
is stored through libsecret. GDM automatic login supplies no password to
`pam_gnome_keyring`, so the persistent login collection remains locked. Typical
symptoms are:

- `grdctl rdp set-credentials ...` waits indefinitely
- `grdctl status` reports an empty username and password
- logs contain `gkr-pam: no password is available for user`
- Remote Login works, but Desktop Sharing rejects authentication

The solution used here keeps the long-lived credential encrypted with
`systemd-creds`. A small system service loads it into the unlocked, in-memory
Secret Service `session` collection whenever the user bus or keyring daemon is
created. GNOME Remote Desktop then reads it through its normal libsecret schema.

## Architecture

```text
Remmina / FreeRDP
       |
       | RDP + NLA, TCP 3390, GFX
       v
gnome-remote-desktop -- user Desktop Sharing
       |
       | org.gnome.RemoteDesktop.RdpCredentials
       v
Secret Service session collection (volatile, unlocked)
       ^
       | restored when the session bus/keyring PID changes
       |
gnome-rdp-session-credential-loader
       ^
       | systemd LoadCredentialEncrypted=
       |
/etc/credstore.encrypted/gnome-rdp-<user>
```

The encrypted file is never committed. The repository contains only the loader,
systemd template, installer, and this explanation.

## Reusable Installer

Run the installer as the desktop user from this repository:

```bash
cd lazy-hacks/remote-desktop/scripts
chmod +x install-gnome-rdp-autologin-desktop-sharing.sh
./install-gnome-rdp-autologin-desktop-sharing.sh
```

Options:

```bash
./install-gnome-rdp-autologin-desktop-sharing.sh \
  --rdp-user '<rdp-user>' \
  --port 3390
```

It performs these operations:

1. Installs GNOME RDP, Avahi/mDNS, libsecret tools, OpenSSL, and Python GI.
2. Generates a self-signed server certificate with DNS and IP subject alternate
   names.
3. fixes Desktop Sharing to port `3390`, disables port negotiation, enables
   input control, and enables the user RDP backend.
4. Serializes the username/password as the exact GLib `a{sv}` value expected by
   GNOME Remote Desktop.
5. Loads an immediate copy into the Secret Service `session` collection.
6. Encrypts the persistent copy with `systemd-creds` and installs the loader.
7. Enables the user RDP daemon and the system credential-loader instance.

The password is read without terminal echo. It is not placed in shell history or
written into the repository.

Companion files:

- [credential loader](./scripts/gnome-rdp-session-credential-loader.sh)
- [systemd template](./scripts/gnome-rdp-session-credentials@.service)
- [installer](./scripts/install-gnome-rdp-autologin-desktop-sharing.sh)

## Manual Reconstruction

The following sections explain what the installer does and record the exact
methods used on the 3040.

### Install Packages

```bash
sudo apt-get install -y \
  avahi-daemon \
  gnome-remote-desktop \
  libnss-mdns \
  libsecret-tools \
  openssl \
  python3-gi
sudo systemctl enable --now avahi-daemon.service
```

Use the `.local` name from another Linux machine:

```bash
getent ahostsv4 OptiPlex-3040.local
ping OptiPlex-3040.local
```

Plain `ping OptiPlex-3040` may fail because mDNS uses the `.local` suffix.

### Fix The Desktop Sharing Port

The system daemon owns `3389`, so give the user daemon a stable port:

```bash
grdctl rdp set-port 3390
grdctl rdp disable-port-negotiation
grdctl rdp disable-view-only
grdctl rdp enable
systemctl --user enable --now gnome-remote-desktop.service
```

Without `disable-port-negotiation`, GNOME may silently choose another port when
`3389` is occupied.

### Generate A Certificate That Matches The Host

GNOME's generated certificate used `CN=GNOME`, which caused hostname-mismatch
warnings. The replacement certificate includes the mDNS name, short hostname,
and current LAN address:

```bash
host_short="$(hostname -s)"
host_mdns="$host_short.local"
host_ipv4="$(hostname -I | awk '{print $1}')"
cert_dir="$HOME/.local/share/gnome-remote-desktop/certificates"

install -d -m 0700 "$cert_dir"
openssl req -x509 -newkey rsa:3072 -sha256 -nodes -days 3650 \
  -keyout "$cert_dir/$host_short-rdp.key" \
  -out "$cert_dir/$host_short-rdp.crt" \
  -subj "/CN=$host_mdns/O=GNOME Remote Desktop" \
  -addext "subjectAltName=DNS:$host_mdns,DNS:$host_short,IP:$host_ipv4" \
  -addext 'keyUsage=critical,digitalSignature,keyEncipherment' \
  -addext 'extendedKeyUsage=serverAuth'
chmod 0600 "$cert_dir/$host_short-rdp.crt" \
  "$cert_dir/$host_short-rdp.key"

grdctl rdp set-tls-cert "$cert_dir/$host_short-rdp.crt"
grdctl rdp set-tls-key "$cert_dir/$host_short-rdp.key"
systemctl --user restart gnome-remote-desktop.service
```

The verified 3040 Desktop Sharing certificate fingerprint was:

```text
SHA256 DD:7A:11:E7:E2:4F:A7:B8:2D:BC:21:7B:34:01:3B:F7:
       21:87:65:D4:A3:5F:7E:39:CF:0F:98:D4:29:3C:A9:D9
```

Verify a certificate before trusting it on a client:

```bash
openssl x509 -in "$cert_dir/$host_short-rdp.crt" \
  -noout -subject -ext subjectAltName -fingerprint -sha256
```

### Store The Immediate Session Credential

GNOME Remote Desktop stores an `a{sv}` GLib variant, not a plain password. Use
GLib to serialize it safely so quotes or backslashes in a password are handled
correctly:

```bash
read -r -p 'RDP username: ' rdp_user
read -r -s -p 'RDP password: ' rdp_password
printf '\n'

serialize_rdp_credentials() {
  {
    printf '%s\0' "$rdp_user"
    printf '%s' "$rdp_password"
  } | python3 -c '
import sys
from gi.repository import GLib

username, password = sys.stdin.buffer.read().split(b"\0", 1)
value = GLib.Variant("a{sv}", {
    "username": GLib.Variant("s", username.decode("utf-8")),
    "password": GLib.Variant("s", password.decode("utf-8")),
})
sys.stdout.write(value.print_(True))
'
}

serialize_rdp_credentials | secret-tool store \
  --collection=session \
  --label='GNOME Remote Desktop RDP credentials' \
  xdg:schema org.gnome.RemoteDesktop.RdpCredentials
```

Confirm only whether credentials exist; do not print them:

```bash
grdctl status
```

Expected fields:

```text
Port: 3390
View-only: no
Negotiate port: no
Username: (hidden)
Password: (hidden)
```

### Make The Session Credential Persistent

Install the loader and template from this repository:

```bash
sudo install -D -o root -g root -m 0755 \
  scripts/gnome-rdp-session-credential-loader.sh \
  /usr/local/libexec/gnome-rdp-session-credential-loader
sudo install -D -o root -g root -m 0644 \
  scripts/gnome-rdp-session-credentials@.service \
  /etc/systemd/system/gnome-rdp-session-credentials@.service
```

Encrypt the same serialized value. Replace `<desktop-user>` but do not put the
password directly into this command:

```bash
desktop_user="$(id -un)"
credential_dir=/etc/credstore.encrypted
credential_file="$credential_dir/gnome-rdp-$desktop_user"

sudo systemd-creds setup
sudo install -d -o root -g root -m 0700 "$credential_dir"
serialize_rdp_credentials | sudo systemd-creds encrypt \
  --with-key=host \
  --name=rdp-credentials \
  - "$credential_file.new"
sudo chown root:root "$credential_file.new"
sudo chmod 0600 "$credential_file.new"
sudo mv "$credential_file.new" "$credential_file"
unset rdp_password

sudo systemctl daemon-reload
sudo systemctl enable --now \
  "gnome-rdp-session-credentials@$desktop_user.service"
```

The loader tracks both the user-bus socket inode and the Secret Service PID. It
restores the item when either changes, then restarts the user RDP daemon.

The machine-specific installed files were:

```text
/usr/local/libexec/gnome-rdp-session-credential-loader
/etc/systemd/system/gnome-rdp-session-credentials.service
/etc/credstore.encrypted/optiplex-3040-rdp
/var/lib/systemd/credential.secret
```

The reusable template uses `gnome-rdp-<desktop-user>` instead of the historical
`optiplex-3040-rdp` filename. The original 3040 deployment also used the fixed
unit name `gnome-rdp-session-credentials.service`; the reusable installer uses
the instance `gnome-rdp-session-credentials@<desktop-user>.service`.

### Keep Remote Login As A Fallback

The system daemon was retained on `3389`:

```bash
sudo grdctl --system rdp set-port 3389
sudo grdctl --system rdp disable-port-negotiation
sudo grdctl --system rdp set-credentials '<rdp-user>' '<rdp-password>'
sudo grdctl --system rdp enable
sudo systemctl enable --now gnome-remote-desktop.service
```

This credential is independent from the user's libsecret item. On hardware
without a TPM, this message was non-fatal:

```text
Init TPM credentials failed because No TPM device found, using GKeyFile as fallback.
```

See [GNOME System RDP Remote Login](./gnome-system-rdp-remote-login-on-ubuntu-24-04.md)
for the complete login-screen path.

## Passwordless SSH From The Client

A dedicated ED25519 key avoids changing unrelated SSH identities:

```bash
ssh-keygen -t ed25519 \
  -f "$HOME/.ssh/id_ed25519_optiplex_3040" \
  -N '' \
  -C 'client to OptiPlex-3040'
ssh-copy-id -i "$HOME/.ssh/id_ed25519_optiplex_3040.pub" \
  malab@192.168.1.209
```

The client configuration used was:

```sshconfig
Host optiplex-3040 OptiPlex-3040 OptiPlex-3040.local 192.168.1.209
    HostName OptiPlex-3040.local
    HostKeyAlias 192.168.1.209
    User malab
    IdentityFile ~/.ssh/id_ed25519_optiplex_3040
    IdentitiesOnly yes
    PreferredAuthentications publickey
    ServerAliveInterval 30
    ServerAliveCountMax 3
    TCPKeepAlive yes
    StrictHostKeyChecking yes
```

`HostKeyAlias` reuses the already-verified IP entry in `known_hosts` while the
connection itself follows the mDNS name. A new deployment should verify the key
fingerprint before accepting it.

Fingerprints recorded during this setup:

```text
Dedicated client public key:
SHA256:wIGUjxpW13fjhbiRw6bGjg4+Xfuc6S9CaQbdBgacZhI

OptiPlex-3040 SSH host ED25519 key:
SHA256:mXB4FCzGC2mMYXLlb35AxUTshrbthz/LMHb89A1uOOU
```

Both forms were tested with password fallback disabled:

```bash
ssh -o BatchMode=yes optiplex-3040 'hostname; id -un'
ssh -o BatchMode=yes malab@192.168.1.209 'hostname; id -un'
```

If a custom key works only with `ssh optiplex-3040` but the raw-IP command asks
for a password, the raw IP is missing from the `Host` patterns.

On Ubuntu 24.04, `ssh.service` may report `disabled` while socket activation is
correctly enabled. Check both state and listener:

```bash
systemctl is-enabled ssh.socket
systemctl is-active ssh.socket
ss -ltnp | rg ':22\b'
```

## Remmina Client Profile

The saved profile was named `OptiPlex 3040 - Desktop` and used:

```ini
[remmina]
name=OptiPlex 3040 - Desktop
protocol=RDP
server=OptiPlex-3040.local:3390
username=malab
password=.
resolution_mode=2
colordepth=99
network=lan
quality=9
disableclipboard=0
disableautoreconnect=0
rdp_reconnect_attempts=10
sound=local
window_maximize=1
cert_ignore=0
```

Important values:

- `resolution_mode=2` enables dynamic resolution.
- `colordepth=99` lets Remmina advertise the Graphics Pipeline and negotiate the
  best 32-bit GFX codec.
- `password=.` means the password is in the local keyring, not the profile.
- `cert_ignore=0` keeps certificate checking enabled.

Store a profile password through Remmina without writing it into the file:

```bash
read -r -s -p 'RDP password: ' remmina_password
printf '\n'
printf '%s\n%s\n' 'malab' "$remmina_password" | \
  remmina --update-profile /path/to/optiplex-3040.remmina \
    --set-option username \
    --set-option password
unset remmina_password
chmod 0600 /path/to/optiplex-3040.remmina
```

The current workstation profile is:

```text
~/.local/share/remmina/group_rdp_quick-connect_192-168-1-209.remmina
```

To pre-pin the verified server certificate for the mDNS endpoint:

```bash
remote_cert=.local/share/gnome-remote-desktop/certificates/OptiPlex-3040-rdp.crt
scp "optiplex-3040:$remote_cert" \
  /tmp/optiplex-3040-rdp.crt
openssl x509 -in /tmp/optiplex-3040-rdp.crt -noout -fingerprint -sha256
install -m 0600 /tmp/optiplex-3040-rdp.crt \
  "$HOME/.config/freerdp/server/optiplex-3040.local_3390.pem"
```

Adjust the certificate filename if the installer generated a lowercase hostname.

## Verification

### Service And Listener Checks

Run on the target:

```bash
grdctl status
systemctl --user is-enabled gnome-remote-desktop.service
systemctl --user is-active gnome-remote-desktop.service
sudo systemctl is-enabled \
  "gnome-rdp-session-credentials@$(id -un).service"
sudo systemctl is-active \
  "gnome-rdp-session-credentials@$(id -un).service"
ss -ltnp | rg ':(3389|3390)\b'
```

For the historical fixed-name unit on the 3040, use:

```bash
sudo systemctl status gnome-rdp-session-credentials.service
```

If UFW is active, scope access to the LAN rather than opening RDP globally:

```bash
sudo ufw allow from 192.168.1.0/24 to any port 3390 proto tcp
sudo ufw status verbose
```

Do not forward RDP directly from the internet. Use a VPN for off-LAN access.

### Authentication-Only Test

Run from a Linux client with FreeRDP 3:

```bash
xfreerdp3 \
  /v:OptiPlex-3040.local:3390 \
  /u:'<rdp-user>' \
  /from-stdin:force \
  +auth-only \
  /cert:tofu \
  /log-level:WARN
```

With this FreeRDP build, the useful line was:

```text
Authentication only, exit status 1
```

A deliberately wrong password produced `exit status 0` plus
`ERRCONNECT_AUTHENTICATION_FAILED`. The process exit codes themselves were less
intuitive, so compare the FreeRDP status line and server logs.

### Full Graphics And Input Test

GNOME rejected clients that did not advertise the Graphics Pipeline:

```text
[RDP] Client did not advertise support for the Graphics Pipeline, closing connection
```

Use `+gfx` for a direct FreeRDP test:

```bash
xfreerdp3 \
  /v:OptiPlex-3040.local:3390 \
  /u:'<rdp-user>' \
  /from-stdin:force \
  /cert:tofu \
  /size:1920x1080 \
  +gfx \
  +dynamic-resolution \
  +clipboard \
  /network:lan
```

The verified test displayed the live Firefox and Terminal windows from the 3040.
Mouse input selected Firefox's search field, and keyboard input changed its text;
the original text was restored afterward.

### Credential Recovery Test

This simulates the important part of a reboot without interrupting the machine:

```bash
desktop_user="$(id -un)"
unit="gnome-rdp-session-credentials@$desktop_user.service"

sudo systemctl stop "$unit"
systemctl --user restart gnome-keyring-daemon.service
grdctl status

sudo systemctl start "$unit"
sleep 7
grdctl status
```

Before the loader starts, the username/password should be `(empty)`. After it
starts, both should be `(hidden)`, and port `3390` should still be listening.

This recovery test passed on the 3040. A disruptive full reboot was deliberately
not performed while the machine was in use.

For the historical fixed-name deployment, set:

```bash
unit=gnome-rdp-session-credentials.service
```

## Troubleshooting

### `grdctl rdp set-credentials` Hangs

Check the login collection:

```bash
busctl --user get-property \
  org.freedesktop.secrets \
  /org/freedesktop/secrets/collection/login \
  org.freedesktop.Secret.Collection \
  Locked
```

If it returns `b true` under automatic login, do not keep launching
`gnome-keyring-daemon --unlock`. Each invocation can create an extra daemon if it
does not attach to the existing control socket. Use the session-collection loader
instead.

Do not delete a nonempty login keyring. The 3040 keyring reset was considered
safe only after `file` reported `0 item(s)`, and the original 105-byte file was
moved to:

```text
~/.local/share/keyrings-backup/
```

### RDP Reaches GDM But Cannot Log In

You connected to system Remote Login on `3389`. Use `3390` to share the active
desktop, or log out the local session before using Remote Login.

### RDP Authentication Works But The Display Disconnects

Enable GFX. Remmina's automatic color depth does this; raw `xfreerdp3` needs
`+gfx` explicitly.

### Hostname Does Not Resolve

Use `OptiPlex-3040.local`, then verify Avahi:

```bash
systemctl is-active avahi-daemon.service
getent ahostsv4 OptiPlex-3040.local
```

### Direct-IP SSH Still Asks For A Password

The dedicated private key has a nonstandard filename, so SSH will not discover it
unless a matching `Host` block selects it. Add the IP to that block and verify:

```bash
ssh -G malab@192.168.1.209 | rg \
  '^(hostname|user|identityfile|identitiesonly|preferredauthentications) '
ssh -o BatchMode=yes malab@192.168.1.209 true
```

### Inspect Logs

```bash
journalctl --user -u gnome-remote-desktop.service --since '10 minutes ago'
sudo journalctl -u gnome-remote-desktop.service --since '10 minutes ago'
sudo journalctl -u \
  "gnome-rdp-session-credentials@$(id -un).service" \
  --since '10 minutes ago'
```

## Security Notes

- Never commit the encrypted credential blob, host credential key, RDP password,
  SSH private key, Remmina secret, or keyring files.
- `systemd-creds` protects the credential from casual disclosure and keeps it out
  of scripts. Without full-disk encryption, an offline attacker who obtains both
  the host key and encrypted blob can still recover it.
- The loader runs as the desktop user with a read-only system/home view and only
  the Unix address family enabled.
- Keep certificate checking enabled and verify the SHA-256 fingerprint before
  pinning a new certificate.
- Keep RDP on a trusted LAN or behind a VPN. Do not expose `3389` or `3390`
  directly to the public internet.
- Use a dedicated RDP password if policy allows. Do not record it in command
  examples, Git, shell history, or issue logs.

## Rollback

Replace `<desktop-user>` before running:

```bash
desktop_user='<desktop-user>'

grdctl rdp disable
systemctl --user restart gnome-remote-desktop.service

sudo systemctl disable --now \
  "gnome-rdp-session-credentials@$desktop_user.service"
sudo rm -f \
  /etc/systemd/system/gnome-rdp-session-credentials@.service \
  /usr/local/libexec/gnome-rdp-session-credential-loader \
  "/etc/credstore.encrypted/gnome-rdp-$desktop_user"
sudo systemctl daemon-reload
```

This does not remove OpenSSH, Avahi, GNOME Remote Desktop, certificates, or the
system Remote Login fallback. Remove those separately only when they are no
longer needed.
