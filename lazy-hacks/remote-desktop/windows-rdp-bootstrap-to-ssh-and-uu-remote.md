# Bootstrap Windows Access with RDP, OpenSSH, and UU Remote

This runbook records how an Ubuntu workstation used RDP once to turn a Windows
machine into a durable remote target. The resulting access ladder is:

1. RDP for the initial interactive bootstrap and emergency GUI access.
2. OpenSSH with a dedicated key for routine administration.
3. NetEase UU Remote for phone and cross-device desktop control.

The commands deliberately exclude passwords, private keys, UU account tokens,
and temporary UU connection or verification codes.

## Verified Machine State

Audited on 2026-07-16:

| Item | Verified value |
| --- | --- |
| Ubuntu controller | `OptiPlex-7090`, Ubuntu 24.04 |
| Windows target | `DESKTOP-SEG67L9`, LAN address `192.168.1.99` |
| Windows account | `lachlan`, member of local Administrators |
| RDP | TCP 3389 listening, Network Level Authentication enabled |
| Remmina profile | `Windows - DESKTOP-SEG67L9`, 32-bit color, LAN quality |
| SSH alias | `windows-seg67l9` |
| OpenSSH Server | Installed, running, automatic startup, TCP 22 |
| SSH firewall scope | All Windows network profiles, remote address `LocalSubnet` only |
| UU Remote | Version `4.31.1.8795`, native Windows installation |
| UU install directory | `C:\zml\GameViewer\bin` |
| UU service | `GameViewerService`, running with automatic startup |

Versions and session IDs will change. Treat the table as an audit record, not as
a requirement to install an old release.

## 1. Bootstrap Through Remmina RDP

Install Remmina and its RDP plugin on Ubuntu if needed:

```bash
sudo apt update
sudo apt install remmina remmina-plugin-rdp
```

Create a Remmina profile with these values:

| Setting | Value |
| --- | --- |
| Protocol | RDP |
| Server | `192.168.1.99` |
| Username | `lachlan` |
| Network connection | LAN |
| Color depth | 32 bpp |
| Resolution | Use the client resolution |
| Clipboard | Enabled |

The working profile also redirected this Ubuntu directory:

```text
/home/lachlan/Projects/windows-remote-setup
```

It was exposed to Windows with the share name `SSH-Setup`, so it appeared in
the RDP session as:

```text
\\tsclient\SSH-Setup
```

Apply drive-redirection changes by disconnecting and reconnecting the RDP
session. Keep any saved RDP password in the desktop keyring, never in this
repository or a `.remmina` file committed to Git.

## 2. Create a Dedicated Ubuntu-to-Windows Key

Generate a key on Ubuntu. Do not overwrite an existing key:

```bash
ssh-keygen \
  -t ed25519 \
  -f ~/.ssh/id_ed25519_windows_seg67l9 \
  -C 'lachlan@OptiPlex-7090-to-DESKTOP-SEG67L9'
```

Only place the public half in the RDP share:

```bash
cp ~/.ssh/id_ed25519_windows_seg67l9.pub \
  ~/Projects/windows-remote-setup/controller-key.pub

cp lazy-hacks/remote-desktop/scripts/enable-windows-openssh.ps1 \
  ~/Projects/windows-remote-setup/
```

Never copy `~/.ssh/id_ed25519_windows_seg67l9` to Windows or into the repo.

## 3. Enable Windows OpenSSH from the RDP Session

Inside the Windows RDP desktop, open PowerShell with **Run as administrator**.
Run the reusable helper from the redirected folder:

```powershell
Set-Location '\\tsclient\SSH-Setup'

powershell.exe `
  -NoProfile `
  -ExecutionPolicy Bypass `
  -File .\enable-windows-openssh.ps1 `
  -PublicKeyPath .\controller-key.pub
```

The helper performs these idempotent operations:

- installs the Windows optional capability `OpenSSH.Server~~~~0.0.1.0`
- sets `sshd` to automatic startup and starts it
- creates or repairs the `OpenSSH-Server-In-TCP` firewall rule
- allows TCP 22 from `LocalSubnet`, without exposing it to the internet
- adds the supplied public key without duplicating it
- uses the administrator-specific key file:
  `C:\ProgramData\ssh\administrators_authorized_keys`
- removes inherited ACLs and grants full control only to SYSTEM and the local
  Administrators group
- restarts `sshd` and prints a short validation summary

The administrator key path matters because the stock Windows configuration
contains this match block:

```sshconfig
Match Group administrators
       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```

Putting an administrator's key only in
`C:\Users\<user>\.ssh\authorized_keys` will therefore fail with the default
configuration.

## 4. Add the Ubuntu SSH Alias

Add this block to `~/.ssh/config` on Ubuntu:

```sshconfig
Host windows-seg67l9
    HostName 192.168.1.99
    User lachlan
    IdentityFile ~/.ssh/id_ed25519_windows_seg67l9
    IdentitiesOnly yes
    ServerAliveInterval 30
    StrictHostKeyChecking accept-new
```

Secure the local files and test key-only login:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config ~/.ssh/id_ed25519_windows_seg67l9
chmod 644 ~/.ssh/id_ed25519_windows_seg67l9.pub

ssh -o BatchMode=yes -o ConnectTimeout=5 windows-seg67l9 whoami
ssh windows-seg67l9 hostname
```

Expected identity and host:

```text
desktop-seg67l9\lachlan
DESKTOP-SEG67L9
```

Do not disable password authentication until key login succeeds from a second
terminal. RDP remains the recovery path if SSH configuration is damaged.

## 5. Validate OpenSSH on Windows

Run these checks in an elevated Windows PowerShell:

```powershell
Get-WindowsCapability -Online -Name 'OpenSSH.Server*'
Get-Service sshd
Get-NetTCPConnection -State Listen -LocalPort 22

$rule = Get-NetFirewallRule -Name 'OpenSSH-Server-In-TCP'
$rule | Format-List Name, Enabled, Action, Profile
$rule | Get-NetFirewallPortFilter
$rule | Get-NetFirewallAddressFilter

Get-Acl 'C:\ProgramData\ssh\administrators_authorized_keys' |
  Format-List Owner, AccessToString
```

The verified ACL has only these effective entries:

```text
NT AUTHORITY\SYSTEM: FullControl
BUILTIN\Administrators: FullControl
```

If the target was reinstalled and SSH reports a changed host key, first verify
the machine through RDP. Then remove only the stale alias/IP entries:

```bash
ssh-keygen -R windows-seg67l9
ssh-keygen -R 192.168.1.99
```

See also [Windows remote keyboard and OpenSSH notes](../windows-remote-keyboard-and-ssh.md)
for two-way SSH setup and Caps Lock recovery.

## 6. Install Native UU Remote on Windows

Perform the initial installation inside RDP because the installer and login are
interactive.

1. Download the current Windows installer only from the
   [official NetEase UU Remote site](https://uuyc.163.com/).
2. Verify the installer before running it.
3. Run it as administrator and choose the install directory.
4. Start UU Remote and sign in using its QR or SMS flow.
5. Confirm the Windows device appears in the same UU account on the controlling
   phone or computer.

Verify the downloaded installer in PowerShell:

```powershell
$installer = "$HOME\Downloads\uuyc_setup.exe"
$signature = Get-AuthenticodeSignature -FilePath $installer

$signature | Format-List Status, StatusMessage
$signature.SignerCertificate | Format-List Subject, Issuer, NotAfter
```

Proceed only when `Status` is `Valid` and the signer subject identifies:

```text
NetEase (Hangzhou) Network Co., Ltd
```

Start the interactive installer:

```powershell
Start-Process -FilePath $installer -Verb RunAs -Wait
```

The audited machine used a custom destination. Its uninstall registry entry is:

```text
DisplayName:     UU Remote
DisplayVersion:  4.31.1.8795
InstallLocation: C:\zml\GameViewer\bin
UninstallString: C:\zml\GameViewer\bin\Uninstall.exe
```

Launch the installed client from the RDP desktop:

```powershell
Start-Process 'C:\zml\GameViewer\bin\GameViewerLauncher.exe'
```

Do not save account tokens or rotating connection/verification codes in shell
history, scripts, screenshots, or Git.

## 7. Verify UU Remote

Check the service, signatures, and active processes:

```powershell
Get-CimInstance Win32_Service -Filter "Name='GameViewerService'" |
  Select-Object Name, State, StartMode, PathName

Get-AuthenticodeSignature `
  'C:\zml\GameViewer\bin\GameViewerServer.exe' |
  Select-Object Status, SignerCertificate

Get-Process GameViewer* -ErrorAction SilentlyContinue |
  Select-Object ProcessName, Id, SessionId
```

The healthy audited layout was:

| Process | Session |
| --- | --- |
| `GameViewerService.exe` | Windows service session 0 |
| `GameViewerHealthd.exe` | console/helper session 1 |
| `GameViewer.exe` | active RDP user session 2 |
| `GameViewerServer.exe` | active RDP user session 2 |

The numeric session IDs are temporary. The client and server must be in the
currently interactive user's session.

## 8. Launch the UU GUI from SSH

A process started normally over Windows OpenSSH belongs to a noninteractive
session, so its GUI will not appear in RDP. Find the current session first:

```bash
ssh windows-seg67l9 'query session'
```

Open an interactive Windows PowerShell over SSH for the remaining commands:

```bash
ssh -t windows-seg67l9 powershell.exe -NoLogo -NoProfile
```

On the audited host, UU bundled Microsoft Sysinternals PsExec 2.43 at:

```text
C:\zml\GameViewer\bin\bin\PsExec64.exe
```

Its Authenticode signature was valid and its signer was Microsoft Corporation.
Verify it again before use:

```powershell
Get-AuthenticodeSignature `
  'C:\zml\GameViewer\bin\bin\PsExec64.exe' |
  Select-Object Status, SignerCertificate
```

Replace `2` with the active user session ID reported by `query session`:

```powershell
& 'C:\zml\GameViewer\bin\bin\PsExec64.exe' `
  -accepteula `
  -i 2 `
  -d `
  'C:\zml\GameViewer\bin\GameViewerLauncher.exe'
```

This command is only needed when launching the GUI from SSH. When already in
RDP, start the launcher normally.

## Recovery Order

When remote access fails, check the least invasive path first:

1. `ping 192.168.1.99` or inspect the router's active-client list.
2. `ssh -o ConnectTimeout=5 windows-seg67l9 whoami`.
3. Connect through the saved RDP profile.
4. Open UU Remote from another enrolled device.
5. From RDP, repair `sshd`, its firewall rule, or UU's service.

Do not port-forward RDP, SSH, or UU's local service ports directly to the public
internet. Use LAN access, UU's authenticated relay, or a trusted VPN.
