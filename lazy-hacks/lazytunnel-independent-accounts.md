# LazyTunnel: independent accounts on one relay

LazyTunnel CLI **0.3.0** adds a reusable account boundary to the SSH core behind
[LazyRemote](https://remote.lazying.art). One person can host their own devices;
a service operator can host several independent accounts on the same server.
The code remains MIT licensed, and the server/client work without either GUI.

Full operator and user guide:
[LazyTunnel/docs/accounts.md](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/accounts.md).

## Installation and daily commands

On a Linux relay with OpenSSH, systemd, Python 3.9+, sudo, iproute2 and Node 22+:

```bash
npm install -g @lazyingart/lazytunnel
sudo lazytunnel-server install --apply
# New relay only; use the SSH port already configured on your server.
sudo lazytunnel-server account init --host relay.example.com --port 22 \
  --host-key-file /etc/ssh/ssh_host_ed25519_key.pub --apply
sudo lazytunnel-server account add alice --key-file /private/alice.pub --apply
sudo lazytunnel-server account invite alice --output /private/alice.json
```

The user creates the account key on their own computer with `ssh-keygen -t
ed25519 -f ~/.ssh/lazytunnel-account` and gives only its public file to the
operator. The invitation pins the server identity and contains no secret.
Deliver it through a trusted channel. The full guide includes secure password
accounts and a root-runtime command when npm/Node is outside sudo's PATH.

Each client needs its own SSH server and readable host public key. Then:

```bash
npm install -g @lazyingart/lazytunnel
lazytunnel-client install
lazytunnel-client login --invite alice.json --name laptop \
  --identity ~/.ssh/lazytunnel-account
lazytunnel-client boot
lazytunnel-client account devices --identity ~/.ssh/lazytunnel-account
```

Enroll another device with the same invitation and a different name. On the
existing devices, refresh the account's destinations and authorized keys:

```bash
lazytunnel-client sync
lazytunnel-client ssh workstation hostname
ssh-lazy-workstation
scp-lazy ./example.txt lazy-workstation:Downloads/
lazytunnel-client web workstation 6080 --local-port 16080
```

The final command forwards an existing web/noVNC service; browse
`http://127.0.0.1:16080` on the client running it. It creates no new desktop.
Account administration requires the account key/password; normal device SSH
and `sync` use the device's separate keys without that credential.

## What the implementation enforces

- Alice cannot list, enroll into, revoke or forward to Bob's account. Both can
  name a device `laptop`; internal identities and relay ports remain unique.
- Account SSH logins have a forced, narrowly scoped helper and no shell, PTY
  or forwarding. sudo supplies the authenticated Unix UID; a JSON owner field
  cannot impersonate another account. The helper accepts only list/enroll/revoke.
- Server-generated `PermitOpen`, authorized keys, known hosts, bundles and
  aliases are filtered by ownership. Isolation is not merely a GUI filter.
- One endpoint OS user has one active enrollment. Accounts mutually trust their
  own devices; guest sharing or multiple unrelated owners of one endpoint's
  shared SSH identity require a separate design.
- Existing version-1 fleets remain unchanged until an explicit account upgrade;
  they then retain their existing identities together in `default`. A code/npm
  update alone changes no live authorization or carrier.
- Device tombstones reserve identities and ports. A repeated enrollment with
  identical credentials is idempotent; implicit transfer and key replacement
  are refused. Limits are 64 accounts, 256 total records and 32 per account.

## Revocation and cached state

```bash
lazytunnel-client account revoke phone --identity ~/.ssh/lazytunnel-account
# On the remaining clients:
lazytunnel-client sync

# Administrator, on the relay:
sudo lazytunnel-server account disable alice --apply
sudo lazytunnel-server account enable alice --apply
```

Relay revocation immediately rejects authorization and closes the affected
account's old jump sessions, so pre-existing permissions cannot linger. Other
accounts' active connections remain running. Same-account shells/forwards can
disconnect; use tmux for ongoing work.

`account devices` queries the live registry; ordinary `devices` and GUI cards
use cached enrollment. Run `sync` after changes. No extra polling daemon was
added. Client sync removes only exact key rows previously managed by LazyTunnel,
preserving unrelated manual keys. Direct LAN access also requires endpoint sync
and review of any separately granted manual keys; cloud revocation alone cannot
remove those keys from an offline endpoint.

Legacy carriers marked `external_carrier` require their administrator's separate
revocation procedure. Account disable fails before applying changes if it would
implicitly revoke one. Public signup, billing, email recovery and native-app
cloud account-login screens are not part of this release. Root operators remain
trusted; account separation does not provide VM-level resource isolation.

## Implementation lessons and verification

The account implementation was tested on disposable Ubuntu 24.04/OpenSSH 9.6
with real SSH and sudo, without exposing a host port or changing production:

1. `sshd -t` alone missed an effective-authentication failure with
   `AuthenticationMethods any` inside a Match block. Explicit key/password
   alternatives plus effective `sshd -T -C` checks avoid that failure. Earlier
   conflicting Match settings are rejected rather than silently taking priority.
2. An owner-only umask made the bundle directory inaccessible even though each
   bundle had the correct per-device owner. The directory needs traversal while
   bundle files stay owner-readable only. Test the authenticated registry read.
3. Reloading SSH does not revoke permissions already held by connected sessions.
   The update selectively ends affected managed SSH identities, while a second
   account's established connection is tested to remain usable.
4. Rollback must preserve the previous manifest, file bytes, modes and owners.
   A deliberately conflicting policy now proves restoration and safe retry.
5. Authentication belongs to OpenSSH; passwords never enter JSON/config/argv.
   Account requests are bounded and serialized, with revision checks. Metadata
   lengths are also bounded to prevent a small request producing huge configs.

Reproduce the checks in the project:

```bash
npm test
npm run test:core
npm run test:accounts:integration
npm run verify:package
```

Docker is required only for the disposable integration test. It reuses the
developer's Node executable, publishes no ports and removes its own container.
Windows/macOS argument and installer safeguards are covered by shared tests;
new account login has not yet had an end-to-end acceptance run on those systems.
This work did not migrate the existing production relay, restart desktop
services or test a reboot. The npm workflow runs real SSH account tests before
publishing with provenance.

Related: [npm installation and publication](lazytunnel-npm-installation.md),
[fleet SSH and noVNC](lazytunnel-fleet-ssh-and-novnc.md).
