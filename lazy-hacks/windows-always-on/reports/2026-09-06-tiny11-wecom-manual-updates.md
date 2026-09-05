# Tiny11 WeCom: manual Windows updates

Date: 2026-09-06, Asia/Hong_Kong.

## Request and scope

After the user's Windows upgrade/reboot, prevent future automatic OS updates
and feature upgrades on the dedicated QEMU WeCom VM. Reuse the existing
WindowsAlwaysOn policy definitions with a new `-UpdatesOnly` option rather
than changing its power or login configuration.

`git pull --ff-only` was run first in the original repository and was already
up to date. No second VM, desktop, Android controller, or WeCom instance was
started. The active WeCom login was preserved.

## Applied configuration

- Windows 11 Pro, 25H2, build 26200.9168.
- `WindowsUpdate\AU\NoAutoUpdate=1`: automatic OS updates disabled.
- `AUOptions=2`, `NoAutoRebootWithLoggedOnUsers=1`, and
  `AlwaysAutoRebootAtScheduledTime=0` provide supporting update policy settings.
- `ProductVersion=Windows 11`, `TargetReleaseVersion=1`, and
  `TargetReleaseVersionInfo=25H2` pin the feature release.
- Feature/quality compliance deadline enable flags are set to zero.
- No services, protected scheduled tasks, service ACLs, update caches, Defender
  settings, power plans, or user login settings were changed.

The feature pin is not a fixed cumulative build pin. Automatic Windows updates
are manual-only; it is incorrect to claim every updater on the machine is off.
Store, Edge, Office, WeCom, firmware, and other application updaters have their
own mechanisms and remain outside this change. Manual security maintenance is
required; this is not a recommendation to leave the VM permanently unpatched.

## Reusable commands

The guest copy is `C:\LabCanvas\WeComBridge\Configure-WindowsAlwaysOn.ps1`.
Reuse the existing localhost SSH connection, not desktop clicks:

```bash
ssh -p 2290 -o BatchMode=yes lachlan@127.0.0.1 powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File C:/LabCanvas/WeComBridge/Configure-WindowsAlwaysOn.ps1 -Mode Status -UpdatesOnly
ssh -p 2290 -o BatchMode=yes lachlan@127.0.0.1 powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File C:/LabCanvas/WeComBridge/Configure-WindowsAlwaysOn.ps1 -Mode Apply -UpdatesOnly
ssh -p 2290 -o BatchMode=yes lachlan@127.0.0.1 powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File C:/LabCanvas/WeComBridge/Configure-WindowsAlwaysOn.ps1 -Mode Restore -UpdatesOnly
```

The first rollback snapshot is preserved at
`C:\ProgramData\LazyingArt\WindowsManualUpdates\state-before-first-apply.json`.
Repeated apply preserves its checksum. Scope mismatches are rejected before
registry writes. Restore changes only the nine managed update values, restoring
original values or removing those initially absent.

Source and destination script checksums should match after SCP. Keep detailed
machine/SID state private; do not commit the generated JSON backups.

## Verification and limitations

Initial read-only inspection found no servicing processes and no CBS or Windows
Update pending reboot. Windows had booted at 2026-09-05 23:46:32 HKT.

Apply completed with policy refresh exit code zero and
`ConfigurationCompliant=true`, `Scope=UpdatesOnly`,
`PowerSettingsManaged=false`. A repeat apply retained the original backup.
Nonzero display/sleep settings remained unchanged. WeCom remained running and
the noVNC endpoint `http://127.0.0.1:6143/` returned HTTP 200.

`Test-WindowsUpdatesOnly.ps1` passed 19 checks on Windows PowerShell, using only
temporary HKCU keys. Coverage includes repeated apply/restore, baseline checksum
preservation, rejection of cross-scope and unrelated rollback targets, and
retention of full-scope policy definitions. The deployed script SHA256 matches
the repository copy. This is not a forced-reboot persistence test.

**At final verification Windows reported both CBS and Windows Update pending
reboot markers.** The boot time had not changed. This means a further servicing
transaction was already pending; policy compliance does not prove that pending
restart is cancelled. No forced reboot, shutdown cancellation, marker deletion,
or servicing termination was attempted. Complete pending servicing in a chosen
maintenance window, then run status again. Do not report unattended reboot
safety until the pending markers are clear.

Separately, the Ubuntu ProjectsLFS volume began returning kernel-confirmed
I/O errors and lost async writes. The LabCanvas WeCom API on localhost 19580
became unreachable even though the Windows app and noVNC remained available.
This is not proof that disabling updates broke WeCom: the guest application was
still running, while the Ubuntu repository volume could no longer reliably be
read. No live-filesystem repair or forced relay restart was attempted.

To preserve the work, the guest script was copied to the independent home
volume and the publication was prepared from a fresh upstream checkout there.
The damaged original repository was left untouched. Recover the storage before
resuming project writes or claiming end-to-end WeCom group delivery is healthy.

## Official policy reference

[Microsoft: Manage additional Windows Update settings](https://learn.microsoft.com/en-us/windows/deployment/update/waas-wu-settings)
documents `NoAutoUpdate=1` and manual installation when automatic updating is
disabled. [Microsoft: Update Policy CSP](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-update)
documents product/target-release and restart policy boundaries.
