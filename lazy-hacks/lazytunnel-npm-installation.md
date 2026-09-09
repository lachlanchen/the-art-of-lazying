# LazyTunnel: install the client and relay through npm

The independent SSH engine behind [LazyRemote](https://remote.lazying.art) is
available as [@lazyingart/lazytunnel](https://www.npmjs.com/package/@lazyingart/lazytunnel).
The first stable npm release is **0.2.1**, published on 2026-09-09 through
GitHub Actions with npm provenance. Native Flutter apps remain separate downloads.

## Install and use

Use Node.js 22+ and npm. Linux/macOS clients also need Python 3.9+ and OpenSSH;
Windows uses its installed PowerShell and OpenSSH. The relay runs on Linux with
OpenSSH Server and systemd.

```bash
npm install -g @lazyingart/lazytunnel
lazytunnel-client --version
lazytunnel-client doctor
lazytunnel-client install
```

For an already enrolled machine:

```bash
lazytunnel-client devices
lazytunnel-client ssh other-device hostname
lazytunnel-client web other-device 6080 --local-port 16080
```

For a new machine, prepare its public enrollment packet and send it to the relay
administrator. After approval, use the private bundle returned for that machine:

```bash
lazytunnel-client prepare --name workstation > workstation-enrollment.json
lazytunnel-client login --bundle /private/workstation-bundle.json
lazytunnel-client boot
```

On Windows, use `--output` instead of shell redirection for the enrollment JSON
to avoid Windows PowerShell's default encoding:

```powershell
lazytunnel-client prepare --name workstation --output "$env:USERPROFILE\workstation-enrollment.json"
lazytunnel-client login --bundle "$env:USERPROFILE\workstation-bundle.json"
lazytunnel-client ssh -Device other-device hostname
```

`lazytunnel` and `lazytunnel client` are equivalent client entry points.
For a temporary invocation, use `npx --yes @lazyingart/lazytunnel --help`.

## Install the server separately

Install the same npm package on the Linux relay. Preview before applying:

```bash
lazytunnel-server install
sudo lazytunnel-server install --apply
sudo lazytunnel-server apply --manifest /private/fleet.json
sudo lazytunnel-server apply --manifest /private/fleet.json --apply
```

Code installation and relay-policy activation are separate operations.
`lazytunnel server` is an equivalent entry point. If npm lives in a user-owned
prefix outside sudo's PATH, use the verified absolute command path with Node
available in that environment. Do not change system PATH or overwrite unrelated
launchers just to get past a command collision.

The [full npm guide](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/npm.md)
covers enrollment, server administration, updates, Windows flags and the
optional Linux controller/browser console. See also the
[fleet architecture](lazytunnel-fleet-ssh-and-novnc.md) and
[native app guide](lazytunnel-native-apps-and-lazyremote.md).

## Why installation is small and predictable

The package is approximately **60 KB compressed**: 32 explicitly allowed files,
zero npm runtime dependencies, and no install lifecycle hooks. Node launches
the existing Python or PowerShell backend with individual arguments; it does
not add a second networking daemon. The package excludes SDKs, Flutter builds,
browser profiles, private manifests, credentials and caches.

Explicit client installation copies code to persistent per-user storage.
Identity and enrollment stay in their existing private directories. The npm
launcher passes `--no-launcher` / `-NoLauncher`, so installing code does not
replace npm command links or rewrite shell startup files. Older checkout-based
installers retain their existing behavior.

An older `~/.local/bin/lazytunnel` may precede npm on PATH. Check with
`command -v lazytunnel`, use the distinct `lazytunnel-client` command, or use
`npx`. Avoid npm `--force` when a pre-existing command belongs to another install.

```bash
npm install -g @lazyingart/lazytunnel@latest
lazytunnel-client update
```

Installing/updating npm or persistent code does not restart SSH carriers,
agents, browser consoles or desktops. Restart an owned agent deliberately if
its running code needs updating. Uninstalling npm is not device revocation.

## Publishing pipeline and the authentication lessons

The package layout follows AgInTiFlow's thin CLI and allowlisted packaging.
The release helper follows LazyNPM's exact-artifact pattern: require a clean
tree, run tests, inspect the tarball, publish once, and compare registry SHA-512
integrity. If the exact version already has identical bytes it succeeds without
republishing; different bytes fail rather than silently bumping or overwriting.

The one-time `0.2.1-bootstrap.0` publish established the package record. The
stable `0.2.1` release then used the narrowly configured trusted publisher:

| Setting | Value |
| --- | --- |
| Package | `@lazyingart/lazytunnel` |
| GitHub repository | `lachlanchen/LazyTunnel` |
| Workflow | `npm-publish.yml` |
| GitHub environment | None |
| Trigger | Matching `npm-vX.Y.Z` tag or exact manual version |
| CI authentication | OIDC; no npm token stored in GitHub |

Trust administration required npm **11.19.1** with `--allow-publish`; the older
11.10 trust request returned HTTP 400. npm 11.10.0 successfully ran the release
workflow itself. Check each command's installed help before assuming newer
administrative flags are available.

The existing private npm browser/CDP profile and registered security key were
reused. No new login account, passkey enrollment, or disabled 2FA was needed.
Two operational problems were found:

1. Chrome returned a non-resident credential assertion without `rpId`. The old
   helper skipped that result and failed to persist the increasing signature
   counter. Reattaching could reuse a counter and npm showed a generic error.
   The helper now matches an unambiguous existing credential ID, preserves its
   RP/key, and saves the actual counter without allowing a stale update to
   decrease it. Unknown IDs are not assigned an origin.
2. Running npm in a home directory containing a project `.npmrc` can override
   the explicitly selected user config. Authentication must be tested from the
   package directory using the same protected config as publication.

Use one controller for security-key assertions and allow persistence to finish
before detaching. Never include approval URLs, cookies, passkeys, tokens, OTPs
or recovery codes in Git, screenshots for sharing, or public troubleshooting logs.

## Verification record

- Nine Node CLI/installation tests and 69 Python core tests passed locally and
  in the stable release workflow.
- The public registry tarball's SHA-512 matched the published integrity;
  GitHub provenance is attached to version 0.2.1.
- A fresh Linux tarball installation exercised all command entry points and
  server installation preview. An isolated-home test repeated client install
  while preserving credentials, launcher bytes and shell profiles.
- A Windows temporary-prefix install passed version/prerequisite checks,
  listed enrolled devices and ran `hostname` on a real remote endpoint via the
  packaged client. The temporary test package did not take over existing tasks.
- The Ubuntu operator installed the public npm release, updated persistent
  client code and successfully reached another enrolled Ubuntu endpoint.
  Existing controller, GUI, UU and XRDP process IDs remained unchanged.

This is package and live-operation validation, not a new reboot test or a
claim that every cloud OS has been migrated to npm. The existing deployed relay
and fleet continue working independently of how their command package is delivered.
