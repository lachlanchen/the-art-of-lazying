param(
    [ValidateSet('Gui', 'Manual', 'Automatic', 'Status', 'Open')]
    [string]$Mode = 'Gui'
)

$ErrorActionPreference = 'Stop'
$scriptPath = $MyInvocation.MyCommand.Path
$auPolicyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-ElevatedMode([string]$RequestedMode) {
    $arguments = @(
        '-NoProfile'
        '-ExecutionPolicy', 'Bypass'
        '-File', ('"{0}"' -f $scriptPath)
        '-Mode', $RequestedMode
    )
    Start-Process powershell.exe -Verb RunAs -ArgumentList $arguments -Wait
}

function Get-UpdateMode {
    $policy = Get-ItemProperty -Path $auPolicyPath -ErrorAction SilentlyContinue
    if ($policy.NoAutoUpdate -eq 1) {
        'Manual only (automatic Windows Update is disabled)'
    } else {
        'Automatic Windows Update'
    }
}

function Set-ManualOnly {
    if (-not (Test-IsAdministrator)) {
        Invoke-ElevatedMode Manual
        return
    }

    New-Item -Path $auPolicyPath -Force | Out-Null
    New-ItemProperty -Path $auPolicyPath -Name NoAutoUpdate -PropertyType DWord -Value 1 -Force | Out-Null
    New-ItemProperty -Path $auPolicyPath -Name AUOptions -PropertyType DWord -Value 2 -Force | Out-Null
    New-ItemProperty -Path $auPolicyPath -Name NoAutoRebootWithLoggedOnUsers -PropertyType DWord -Value 1 -Force | Out-Null
    gpupdate.exe /target:computer /force | Out-Null
    [System.Windows.Forms.MessageBox]::Show(
        'Automatic Windows Update is disabled. Click Check for updates whenever you want to update.',
        'Windows Update: Manual only'
    ) | Out-Null
}

function Set-Automatic {
    if (-not (Test-IsAdministrator)) {
        Invoke-ElevatedMode Automatic
        return
    }

    if (Test-Path $auPolicyPath) {
        Remove-ItemProperty -Path $auPolicyPath `
            -Name NoAutoUpdate, AUOptions, NoAutoRebootWithLoggedOnUsers `
            -ErrorAction SilentlyContinue
    }
    gpupdate.exe /target:computer /force | Out-Null
    [System.Windows.Forms.MessageBox]::Show(
        'Automatic Windows Update is enabled again.',
        'Windows Update: Automatic'
    ) | Out-Null
}

function Open-WindowsUpdate {
    Start-Process 'ms-settings:windowsupdate'
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

switch ($Mode) {
    Manual { Set-ManualOnly }
    Automatic { Set-Automatic }
    Status { Get-UpdateMode }
    Open { Open-WindowsUpdate }
    Gui {
        $form = New-Object System.Windows.Forms.Form
        $form.Text = 'Windows Update Control'
        $form.Size = New-Object System.Drawing.Size(480, 245)
        $form.StartPosition = 'CenterScreen'
        $form.FormBorderStyle = 'FixedDialog'
        $form.MaximizeBox = $false

        $statusLabel = New-Object System.Windows.Forms.Label
        $statusLabel.Location = New-Object System.Drawing.Point(20, 20)
        $statusLabel.Size = New-Object System.Drawing.Size(430, 45)
        $statusLabel.Font = New-Object System.Drawing.Font('Segoe UI', 11)
        $statusLabel.Text = Get-UpdateMode
        $form.Controls.Add($statusLabel)

        $manualButton = New-Object System.Windows.Forms.Button
        $manualButton.Location = New-Object System.Drawing.Point(20, 80)
        $manualButton.Size = New-Object System.Drawing.Size(200, 42)
        $manualButton.Text = 'Use manual updates only'
        $manualButton.Add_Click({ Set-ManualOnly; $statusLabel.Text = Get-UpdateMode })
        $form.Controls.Add($manualButton)

        $automaticButton = New-Object System.Windows.Forms.Button
        $automaticButton.Location = New-Object System.Drawing.Point(240, 80)
        $automaticButton.Size = New-Object System.Drawing.Size(200, 42)
        $automaticButton.Text = 'Restore automatic updates'
        $automaticButton.Add_Click({ Set-Automatic; $statusLabel.Text = Get-UpdateMode })
        $form.Controls.Add($automaticButton)

        $openButton = New-Object System.Windows.Forms.Button
        $openButton.Location = New-Object System.Drawing.Point(20, 140)
        $openButton.Size = New-Object System.Drawing.Size(420, 42)
        $openButton.Text = 'Open Windows Update (check manually)'
        $openButton.Add_Click({ Open-WindowsUpdate })
        $form.Controls.Add($openButton)

        [void]$form.ShowDialog()
    }
}
