# Consistent bidirectional SSH across personal devices

The tested design combines ordinary SSH host aliases, a per-device login
key, pinned host keys, and the existing LazyTunnel reverse listeners. LAN
neighbors connect directly; remote peers use restricted cloud jumps, and
LAN-only devices can sit behind the reachable workstation on their LAN.
UU/RDP/VNC sessions do not own these SSH connections.

The same command can be used from each enrolled computer:

```bash
ssh device-alpha
ssh device-beta hostname
scp ./file.txt device-beta:/tmp/
```

Keep the real device inventory and addresses private. The public enrollment
helpers and complete procedure are in
[LazyTunnel's device SSH guide](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/device-ssh.md).

## Authorization and persistence

Generate keys on their originating devices. Exchange public keys only.
Use different keys for endpoint login and the restricted relay role. Keep
the cloud's exact `PermitOpen` restrictions; adding clients does not require
opening a public desktop port or granting a shell to hop accounts.

The endpoint installer preserves unrelated aliases and key restrictions,
backs up changed files, and includes one managed `devices.conf`. SSH reads
the file on each invocation, so normal aliases do not depend on `.bashrc`.
Existing services provide reverse-listener persistence; enabling aliases
does not create a daemon or prove a reboot test.

The standard Windows administrator key file applies to the administrator
group. Review that boundary before enrolling an administrator account. Keep
its ACL and never replace the whole file to add one peer.

## Windows client caveat found in acceptance

In one Windows SSH-served session, the built-in OpenSSH client hung even
without a configuration file. The already installed Git OpenSSH client
worked for direct connections. A nested jump initially passed its binary
banner through the wrong Windows shell. Running the complete client through
Git Bash with `SHELL=/bin/bash` fixed that tested path.

The optional PowerShell helper in LazyTunnel routes only `device-*` names
through Git's SSH/SCP/SFTP, preserving other hosts and existing user
functions. Source it in an existing terminal or open a new PowerShell window:

```powershell
. "$HOME\.ssh\device-ssh-shell.ps1"
ssh device-beta
ssh-device beta hostname
```

This is a scoped compatibility fallback, not a replacement of Windows
OpenSSH or a claim that all Windows versions need it. Do not pass an SSH
transport stream through a PowerShell text pipeline.

## Verification

Eight reachable endpoints across Linux, macOS and Windows were enrolled.
All 56 non-self directed shell paths passed, including a targeted retest
after one transient banner timeout. The Windows row used the scoped helper.
Small Unicode-content files completed checksum-verified SFTP round trips
between the workstation and every other endpoint. Restricted hop accounts
rejected shell sessions and forwarding to an undeclared port.

Offline computers and phones without a running SSH server remain separate
enrollment work. Do not silently weaken authentication or reboot a device
to fill a matrix. A full directed matrix proves the tested paths at that
time, not unlimited uptime. Use tmux for long-running remote work; automatic
tunnel recovery cannot restore a shell that already lost its TCP connection.

For revocation, remove only the departing device's public login keys and
its separate hop keys. Preserve newer unrelated edits when using backups.
