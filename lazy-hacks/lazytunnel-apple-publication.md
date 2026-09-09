# LazyRemote Apple publication: lessons from EchoMind

Recorded 2026-09-09. The full reusable guide, release plan and readiness script
are maintained in [LazyTunnel](https://github.com/lachlanchen/LazyTunnel/blob/main/docs/apple-publication.md),
the core and native application behind [LazyRemote](https://remote.lazying.art).

## Actual status

EchoMind's live iOS version was **waiting for App Store review**, with manual
release selected. That is evidence of successful submission, not approval or
public availability. Its recent standard publication workflow provides a
useful reference for another app in the same developer team.

LazyRemote itself had no App Store Connect record or registered developer
identifier for either `art.lazying.lazytunnel` or `art.lazying.lazyremote` in the
queried account. Its native source uses `art.lazying.lazytunnel`, version/build
`0.2.0+2`. The existing preview has an iOS simulator build and an unsigned
device build, not an uploaded TestFlight build. No Apple record was created,
and nothing was signed, uploaded, submitted or released during this research.

## Internal testing is not Internal Only distribution

A normal eligible build can be tested internally and then selected for App
Review. Reuse the same tested build rather than rebuilding just to publish.
However, a build exported as **TestFlight Internal Only** cannot be promoted to
App Store distribution; it needs a new normal distribution upload. Apple's API
exposes `APP_STORE_ELIGIBLE` versus `INTERNAL_ONLY`.
[Apple documents this distinction](https://developer.apple.com/help/app-store-connect/test-a-beta-version/add-internal-testers).

External TestFlight beta review and formal App Review are separate paths. An
Android phone, Google production status, matching Android commit or external
beta approval is not required before the Apple submission.

## Keep the workflow simple

1. Register the app's bundle ID and App Store record in the intended team.
2. Archive the exact tested source using normal Xcode/Flutter signing. Export
   an App Store Connect IPA with Internal Only disabled.
3. Verify signatures, profile, entitlements, identity/version, SDK and privacy
   manifests; record the application source and exact artifact SHA-256.
4. Validate/upload that IPA and read back Apple's processing state. If an
   upload times out, inspect Apple before uploading again.
5. Test internally. Complete accurate listing fields, genuine iPhone/iPad
   screenshots, privacy/encryption declarations, age/availability and working
   reviewer access.
6. Select the exact eligible build, choose manual release and submit for review.
7. Read back submission and approval separately. After approval, manually
   release and verify public availability.

Use [Apple's submission workflow](https://developer.apple.com/help/app-store-connect/manage-submissions-to-app-review/submit-an-app)
and [release options](https://developer.apple.com/help/app-store-connect/manage-your-apps-availability/select-an-app-store-version-release-option).
The first release is not a phased version update.

## Practical fixes to reuse

**Signing without weakening the login keychain.** EchoMind's standard builder
uses an owner-private release keychain containing the existing distribution
identity and Apple certificate chain. It restores the original search list and
locks that keychain on completion or failure. Reuse that scoped approach if
remote signing fails. The distribution certificate can cover another app in
the team, but that app still needs its own bundle-specific provisioning profile.

**Export without another build.** Keep a verified archive and use
`xcodebuild -exportArchive` when only export needs to be retried. Track the
application's source commit separately from publication-tool/doc commits.
Changing a document does not change the signed app binary.

**Accurate evidence.** The existing iOS review host produced black captures
for both the app and Safari, despite a Flutter first-frame acknowledgement.
That was not counted as a visual QA pass. Use genuine simulator/device
screenshots after resolving capture; never submit the desktop/Android marketing
images as iOS screenshots.

**App-specific privacy and encryption.** LazyRemote implements SSH through
Dart libraries, so EchoMind's HTTPS-only encryption answers must not be copied.
Review Apple's [encryption documentation requirements](https://developer.apple.com/help/app-store-connect/reference/app-information/export-compliance-documentation-for-encryption)
for the implementation and territories. Do not invent age ratings, exemptions,
privacy answers or functioning reviewer credentials to clear a checklist.
Provide isolated demonstration access rather than production fleet credentials.

## Reusable status command

```bash
cd /path/to/LazyTunnel
python3 scripts/apple_release_status.py
python3 scripts/apple_release_status.py --live
```

Local mode needs no credentials. Live mode performs GET requests only, using
an owner-private `$HOME/.config/lazytunnel/apple-api.json` that references an
existing `.p8` key. It checks the exact app/build, audience and version selection
and reports unfinished plan items. It never changes Apple state. A zero exit
status means the report ran, not that Apple has approved the app or every
Console requirement is satisfied. Credentials and raw account records remain
outside public repositories.

The repository includes an export template, an explicit plan with unknown
values left null, and tests covering Internal Only rejection, mismatched app
identity, wrong/missing selected build and credential-forwarding prevention.
The full Python suite passed **69 tests** at this checkpoint. A live read
confirmed the missing LazyRemote app record. Existing remote-access and fleet
services were unchanged; no reboot or logout was needed.

Reference source: EchoMind's `docs/echomind_standard_publication.md`, effective
2026-09-05, and its standard build/upload/publish scripts. The older cross-store
custody and Android-approval framework is retained by EchoMind for optional
audits; it is not its current default or an Apple requirement.

Related: [native apps, website and preview verification](lazytunnel-native-apps-and-lazyremote.md).
