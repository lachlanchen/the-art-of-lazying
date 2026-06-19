# Windows Remote Keyboard and OpenSSH Notes

These notes cover two practical fixes for a Windows workstation controlled through a remote desktop app:

- letters suddenly typing as uppercase unless `Shift` is held
- setting up SSH in both directions between Windows and a Linux server

## Fix Remote Keyboard Typing All Caps

Symptom:

- Normal letters type as uppercase.
- `Shift` plus a letter types lowercase.

This usually means Windows sees Caps Lock as enabled, even if the local keyboard or remote-control app looks normal. Remote-control software can desynchronize Caps Lock between the local machine and the remote Windows session.

Check and turn Caps Lock off from PowerShell:

```powershell
Add-Type -AssemblyName System.Windows.Forms
$caps = [System.Windows.Forms.Control]::IsKeyLocked([System.Windows.Forms.Keys]::CapsLock)
Write-Host "CapsLock=$caps"

if ($caps) {
  $code = @'
using System;
using System.Runtime.InteropServices;
public static class KeyboardToggle {
  [DllImport("user32.dll")]
  public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
}
'@
  Add-Type $code
  [KeyboardToggle]::keybd_event(0x14, 0x45, 0, [UIntPtr]::Zero)
  [KeyboardToggle]::keybd_event(0x14, 0x45, 2, [UIntPtr]::Zero)
}
```

Manual fallback:

```powershell
osk
```

Then click `Caps Lock` off in the Windows on-screen keyboard.

## SSH From Windows To Linux

Create or reuse a Windows SSH key:

```powershell
ssh-keygen -t ed25519 -f "$HOME\.ssh\id_ed25519"
```

Install the Windows public key on the Linux server:

```powershell
$pub = Get-Content "$HOME\.ssh\id_ed25519.pub"
ssh user@server "umask 077; mkdir -p ~/.ssh; touch ~/.ssh/authorized_keys; grep -qxF '$pub' ~/.ssh/authorized_keys || printf '%s\n' '$pub' >> ~/.ssh/authorized_keys; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys"
```

Add a local Windows SSH alias in:

```text
C:\Users\<windows-user>\.ssh\config
```

Example:

```sshconfig
Host linuxserver
    HostName 192.168.1.99
    User user
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

Test:

```powershell
ssh linuxserver 'hostname && whoami'
```

## SSH From Linux Back To Windows

Install and enable Windows OpenSSH Server:

```powershell
Get-Service sshd
Start-Service sshd
Set-Service -Name sshd -StartupType Automatic
```

Open the firewall for the active network profile:

```powershell
Set-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -Profile Any
```

Find the Windows IP address:

```powershell
Get-NetIPAddress -AddressFamily IPv4 |
  Where-Object {$_.IPAddress -notlike '127.*' -and $_.PrefixOrigin -ne 'WellKnown'} |
  Select-Object InterfaceAlias, IPAddress
```

For a normal Windows user, Linux public keys go here:

```text
C:\Users\<windows-user>\.ssh\authorized_keys
```

For a Windows administrator account, OpenSSH normally uses this file instead:

```text
C:\ProgramData\ssh\administrators_authorized_keys
```

This is controlled by the default Windows OpenSSH config:

```sshconfig
Match Group administrators
       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```

Pull the Linux public keys into the administrator key file from elevated PowerShell:

```powershell
$keys = ssh linuxserver "cat ~/.ssh/id_ed25519.pub ~/.ssh/id_rsa.pub 2>/dev/null"
Add-Content 'C:\ProgramData\ssh\administrators_authorized_keys' $keys
Restart-Service sshd
```

If `Add-Content` appends a key directly after an existing line, fix the file so each key is on its own line. Each valid key line should start with something like `ssh-ed25519` or `ssh-rsa`.

Test from Linux:

```bash
ssh -i ~/.ssh/id_ed25519 -o IdentitiesOnly=yes windows-user@192.168.1.125 'hostname && whoami'
```

If the `ed25519` key entry is malformed or not accepted, test the RSA key:

```bash
ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes windows-user@192.168.1.125 'hostname && whoami'
```

## Fix A Stale Host Key Warning

Symptom:

```text
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED
Host key verification failed.
```

First verify you are connecting to the intended machine. One practical check is to use a temporary known-hosts file:

```powershell
$tmpKnown = Join-Path $env:TEMP 'linuxserver_known_hosts_check'
Remove-Item $tmpKnown -Force -ErrorAction SilentlyContinue
ssh -o UserKnownHostsFile="$tmpKnown" -o StrictHostKeyChecking=accept-new -o BatchMode=yes linuxserver 'hostname && whoami'
```

If that verifies the expected server, remove the stale alias entry:

```powershell
ssh-keygen -R linuxserver -f "$HOME\.ssh\known_hosts"
```

Then reconnect:

```powershell
ssh linuxserver
```
