# Prepare an Apple development workstation

Use Apple's release Xcode from the [Mac App Store](https://apps.apple.com/app/xcode/id497799835).
Wait for the application download to finish before configuring its tools. Signing
into iCloud does not always sign into the App Store; any Apple Account challenge
must be completed by the account owner. Do not replace the OS or enable beta
updates just to install development tools.

## Components

- Xcode includes Swift, Clang, LLDB, Git and platform SDKs. Select full Xcode with
  `xcode-select`, not the standalone Command Line Tools directory.
- The iOS simulator runtime serves both iPhone and iPad development.
- Install watchOS runtime for Apple Watch work; a companion app can require a
  paired iPhone simulator.
- Native macOS applications run on the Mac itself; there is no separate macOS
  simulator runtime to download.
- Metal Toolchain supports shader builds and GPU-related development.
- tvOS, visionOS and historical OS runtimes are optional. Do not download every
  OS version by default on a development machine intended to stay lean.

## Repeatable setup

The script is scoped to preparing tools, not signing identities, app publication,
project migration, an OS upgrade or changing remote-access services.

```sh
# From this repository, on the Mac as the login user:
bash scripts/macos/prepare-apple-development.sh --install
bash scripts/macos/prepare-apple-development.sh --check
```

It selects `/Applications/Xcode.app`, accepts the Xcode license, installs initial
components, downloads current iOS/watchOS simulator runtimes, then installs the
Metal Toolchain. Keep the adjacent `xcode-component-download.py` helper with the
shell script. Each download has at most three attempts, each limited to one hour
(`XCODE_DOWNLOAD_TIMEOUT` overrides the seconds). This bounds a downloader that
otherwise can report `Zero kB of -1 byte` indefinitely. Output goes to private
logs under `~/Library/Logs/DeveloperSetup`; inspect the newest component log for
progress. The wrapper stops its own downloader on timeout, not Apple's shared
network services. Rerun after fixing network errors. Apple handles components
already present. It requests the installed iOS/watchOS SDK versions explicitly
and leaves architecture selection to Xcode (arm64 on this Apple-silicon machine).
After an interrupted transfer, an explicit `-architectureVariant arm64` request
reported no matching downloadable, while `-buildVersion 27.0` with automatic
architecture selection resumed successfully. This is a verified workaround,
not proof of the underlying Apple catalog/network failure. Set `XCODE_APP` to
choose another deliberately installed Xcode version.

Installation also enables Apple's `DevToolsSecurity` policy for an existing
admin/developer account. This removes the extra per-login admin-password prompt
when Apple's signed debugger/profiling tools inspect that user's processes. It
does not disable SIP, Gatekeeper or privacy controls, add users to privileged
groups, or enable Developer Mode on physical phones. Check with
`/usr/sbin/DevToolsSecurity -status`; restore the default prompting policy with
`sudo /usr/sbin/DevToolsSecurity -disable`.

The check mode makes no intentional configuration changes but requires initial
setup to have completed. It prints SDKs, compiler versions, runtime availability,
simulator devices and pairs, and fails if Metal or the matching iOS/watchOS
runtimes are unavailable. It is not proof a device boots or an app's tests pass.
After installation, boot one available iPhone and one compatible
Watch simulator with `xcrun simctl boot` and wait with `xcrun simctl bootstatus
<UUID> -b`. Shut down only the test devices you started, never unrelated user tests.

Use `~/Projects`, `~/RobotData` and the normal `~/Library/Developer` paths. Do not
place simulator disks, build caches or robot datasets in synced Desktop/Documents.
Real-device provisioning and App Store signing are separate per-project steps.

References: [Apple component installation](https://developer.apple.com/documentation/xcode/downloading-and-installing-additional-xcode-components),
[Xcode requirements](https://developer.apple.com/xcode/system-requirements).
