# Keep a Remote Windows Workstation Awake and Update It Manually

This guide is for a Windows workstation that must remain reachable through UU Remote, VNC, Chrome Remote Desktop, RDP, or SSH.

It covers two common surprises:

- Windows starts sleeping even though you remember selecting **Never**.
- Windows downloads updates or restarts when stability matters more than automatic patching.

The commands were tested on Windows 11 on an HP Elite desktop. Run machine-policy commands from an elevated PowerShell window.

## Diagnose Sleep, Restart, and Power Loss

Check the last boot time:

```powershell
$os = Get-CimInstance Win32_OperatingSystem
[pscustomobject]@{
    LastBoot = $os.LastBootUpTime
    Uptime   = (Get-Date) - $os.LastBootUpTime
}
```

Review the relevant System events:

```powershell
$start = (Get-Date).AddDays(-14)
Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    StartTime = $start
    Id        = 1, 41, 42, 1074, 6005, 6006, 6008
} -ErrorAction SilentlyContinue |
    Select-Object TimeCreated, Id, ProviderName, Message |
    Format-Table -Wrap
```

Useful event meanings:

- `42`, Kernel-Power: Windows entered sleep. The message includes the reason, such as `System Idle`.
- `1`, Power-Troubleshooter: Windows woke from sleep and may identify the wake source.
- `1074`, User32: a user, application, or Windows Update initiated a planned shutdown or restart.
- `41`, Kernel-Power plus `6008`, EventLog: Windows booted after an unclean shutdown. This can mean lost power, a hard reset, or a freeze. It does not by itself prove a Windows crash.

If event `41` has `BugcheckCode=0`, no long-power-button timestamp, and no nearby event `1074`, a power interruption or hard freeze is more likely than a normal Windows restart. If you deliberately disconnected power, that fully explains the event.

## Why “Never Sleep” Can Appear to Revert

The sleep timeout belongs to a power plan. Windows can contain Balanced, Power Saver, High Performance, vendor-specific plans, and others. If you set Balanced to **Never** and an HP utility or update later activates **HP Optimized**, the newly active plan can still have a 20-minute timer.

List the plans and identify the active one:

```powershell
powercfg /list
powercfg /getactivescheme
powercfg /query SCHEME_CURRENT SUB_SLEEP
```

## Set Every Existing Plan to Never Sleep on AC Power

This leaves battery/DC behavior unchanged:

```powershell
$schemeGuids = powercfg /list |
    Select-String 'Power Scheme GUID' |
    ForEach-Object {
        if ($_.Line -match '([0-9a-fA-F-]{36})') { $matches[1] }
    } |
    Select-Object -Unique

foreach ($schemeGuid in $schemeGuids) {
    powercfg /setacvalueindex $schemeGuid SUB_SLEEP STANDBYIDLE 0
    powercfg /setacvalueindex $schemeGuid SUB_SLEEP HIBERNATEIDLE 0
    powercfg /setacvalueindex $schemeGuid SUB_SLEEP HYBRIDSLEEP 0

    # Hidden "System unattended sleep timeout" setting
    powercfg /setacvalueindex $schemeGuid SUB_SLEEP `
        7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0
}

powercfg /setactive SCHEME_CURRENT
```

The monitor can still turn off without making remote services unavailable. Display-off and system sleep are separate settings.

## Enforce Never Sleep at Machine-Policy Level

Applying the setting to all current plans is useful, but a vendor tool could add or restore a plan later. These policy values make zero the enforced AC timeout:

```powershell
$base = 'HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings'
$settingIds = @(
    '29f6c1db-86da-48c5-9fdb-f2b67b1f44da', # Sleep after
    '9d7815a6-7ee4-497e-8888-515a05f02364', # Hibernate after
    '7bc4a2f9-d8fc-4469-b07b-33eb785aaca0'  # Unattended sleep
)

foreach ($settingId in $settingIds) {
    $path = Join-Path $base $settingId
    New-Item -Path $path -Force | Out-Null
    New-ItemProperty -Path $path -Name ACSettingIndex `
        -PropertyType DWord -Value 0 -Force | Out-Null
}

gpupdate.exe /target:computer /force
```

Verify the hidden timer with `/qh`, because a normal query does not display hidden settings:

```powershell
powercfg /qh SCHEME_CURRENT SUB_SLEEP 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0
```

## Make Windows Update Manual-Only

Windows automates updates because broadly unpatched machines are a security risk. A remotely operated workstation may instead prioritize predictable uptime. The supported policy approach is preferable to permanently damaging update services: it disables automatic updating while preserving the normal Windows Update page for deliberate checks.

From elevated PowerShell:

```powershell
$au = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
New-Item -Path $au -Force | Out-Null
New-ItemProperty -Path $au -Name NoAutoUpdate `
    -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $au -Name AUOptions `
    -PropertyType DWord -Value 2 -Force | Out-Null
New-ItemProperty -Path $au -Name NoAutoRebootWithLoggedOnUsers `
    -PropertyType DWord -Value 1 -Force | Out-Null
gpupdate.exe /target:computer /force
```

The `wuauserv` or Update Orchestrator service may still show as running. That does not mean the automatic-update policy failed; Windows also uses update components for manual checks and other servicing operations.

Open the GUI whenever you intentionally want to update:

```powershell
Start-Process 'ms-settings:windowsupdate'
```

Manually check approximately once a month, or promptly when an important security fix applies. Microsoft Defender definitions, Store applications, and some vendor tools have separate update mechanisms.

## Add a Desktop Shortcut and GUI Controller

The companion script provides four modes:

```powershell
.\WindowsUpdateControl.ps1 -Mode Gui
.\WindowsUpdateControl.ps1 -Mode Status
.\WindowsUpdateControl.ps1 -Mode Manual
.\WindowsUpdateControl.ps1 -Mode Automatic
```

Download or copy [WindowsUpdateControl.ps1](./scripts/WindowsUpdateControl.ps1), then create a desktop shortcut:

```powershell
$scriptPath = 'C:\path\to\WindowsUpdateControl.ps1'
$shortcutPath = Join-Path ([Environment]::GetFolderPath('Desktop')) `
    'Windows Update Control.lnk'

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = 'powershell.exe'
$shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`" -Mode Gui"
$shortcut.WorkingDirectory = Split-Path $scriptPath
$shortcut.IconLocation = '%SystemRoot%\System32\shell32.dll,167'
$shortcut.Save()
```

Changing update mode triggers UAC. Opening the settings page and reading status do not require elevation.

## Restore Automatic Windows Update

Use the controller's **Restore automatic updates** button, or run this from elevated PowerShell:

```powershell
$au = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
Remove-ItemProperty -Path $au `
    -Name NoAutoUpdate, AUOptions, NoAutoRebootWithLoggedOnUsers `
    -ErrorAction SilentlyContinue
gpupdate.exe /target:computer /force
```

## Recover from Real Power Loss

Windows settings cannot keep a machine online while mains power is absent. For unattended recovery:

- Set firmware **After Power Loss** to **Power On** or **Previous State**.
- Enable Wake-on-LAN as a secondary recovery option.
- Use a UPS if power interruptions are frequent.
- Configure remote-host services for automatic startup and service recovery.

These controls solve different failure modes: no-sleep prevents idle outages, firmware power recovery handles restored electricity, and a UPS prevents the interruption in the first place.
