# Astrill Lazy Router Native Windows Setup

This note records the safe build, installation, and first-run flow for the
native Windows frontend in
[`lachlanchen/astrill-lazy-router`](https://github.com/lachlanchen/astrill-lazy-router).
It intentionally excludes passwords, private/public key bodies, and
machine-specific SSH fingerprints.

## Current Version And Paths

The source snapshot documented here reports application version `0.2.9` and
router companion version `0.2.4`.

| Artifact | Default path |
| --- | --- |
| Workstation checkout | `%USERPROFILE%\Projects\astrill-lazy-router` |
| Build virtual environment | `build\windows-venv` |
| PyInstaller work directory | `build\pyinstaller-windows` |
| Built application folder | `dist\windows\Astrill Lazy Router` |
| Per-user installation | `%LOCALAPPDATA%\Programs\Astrill Lazy Router` |
| Installed executable | `%LOCALAPPDATA%\Programs\Astrill Lazy Router\Astrill Lazy Router.exe` |
| Desktop shortcut | `%USERPROFILE%\Desktop\Astrill Lazy Router.lnk` |
| Login-startup shortcut | `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Astrill Lazy Router.lnk` |
| Configuration | `%LOCALAPPDATA%\Astrill Lazy Router\config.json` |
| Saved endpoint latency | `%LOCALAPPDATA%\Astrill Lazy Router\endpoint-latency.json` |
| App-owned host-key store | `%LOCALAPPDATA%\Astrill Lazy Router\known_hosts` |
| Default dedicated identity | `~/.ssh/astrill_lazy_router_ed25519` |

The PyInstaller result is a folder bundle. Keep the adjacent `_internal`
directory with the executable.

## Native UI

The Windows frontend is a native PySide6/Qt application. It does not need WSL,
GTK, VNC, or noVNC, and it does not install a local VPN, proxy, packet filter,
or network driver. DD-WRT remains the routing enforcement point.

The roomy layout targets `1360 x 860`, has a `960 x 640` minimum, and uses a
fixed navigation sidebar with scrollable content. Its vivid, saturated theme
uses an indigo-to-teal sidebar, purple/cyan accents, white cards, spacious
controls, and distinct status colors. The nine views are Policies, Services,
Countries, Devices, Connection, Endpoints, Astrill, Router, and Settings.

Fresh configurations start native-only, read-only, and with no policy applied.

The desktop reads router status once at startup, but it does not run a
recurring 60-second SSH poll. Later reads happen only through **Refresh
router**, a first page-demand load such as Devices, Endpoints, or Astrill, or
the status returned by an explicit router action. Leaving the app open does
not create periodic desktop-to-router SSH traffic. This affects only the
Windows frontend: the optional companion's router-local watchdog remains on
DD-WRT and continues maintaining its installed routing runtime independently.

The **Astrill** view follows the Ubuntu frontend's human-readable layout. Its
controls are organized into seven spacious tabs: **Overview**, **Connection**,
**Routing**, **Privacy & DNS**, **Devices**, **Resilience**, and **Advanced**.
Friendly labels and appropriate switches, selectors, and text fields make
common settings easier to understand, while the exact NVRAM key remains
visible as secondary metadata for troubleshooting and comparison with DD-WRT.

This presentation layer still reads and writes only the same explicitly
allowlisted, validated NVRAM keys. Loading the page preserves the router's
current values, and read-only mode continues to prevent saves; reorganizing the
controls does not broaden the app's router access or invent replacement
defaults.

The dedicated **Connection** view mirrors Ubuntu's shared-tunnel workflow
without hiding the Windows safety rules. It combines the live tunnel state
with searchable server, favorite, protocol, common port, cipher, MTU,
acceleration, kill-switch, favorite cycling, and router-boot controls. A
router refresh that arrives while the form is dirty preserves the local draft
and shows a conflict banner rather than silently replacing edits.

Its actions have deliberately different meanings:

- **Save** verifies changed connection values while leaving a disconnected
  tunnel stopped; it is unavailable while the tunnel is connected.
- **Connect** starts the tunnel only with the already-saved clean draft.
- **Apply & Connect** or **Apply & Reconnect** saves the validated connection
  values, verifies the readback, and restores previous connection settings if
  the attempt fails.
- **Disconnect** stops the shared tunnel while preserving its endpoint,
  favorites, policies, and other saved settings.

The read-only guard and one-action-at-a-time lock apply to every write. The
Connection and Astrill editors also lock each other's overlapping controls
while either has an unsaved draft. A Connection-page favorite edit uses the
same fresh-read, compare-before-write merge as Endpoints instead of sending a
stale complete list through an ordinary NVRAM write. That favorite merge runs
before Save or Apply; if a later connection step fails, the UI states
explicitly that the already-verified favorite edit remains saved.

## Build And Install

Windows 10 or 11, Python 3.11 or newer, network access for the initial
dependency installation, and Windows OpenSSH Client are required to build.
Check OpenSSH first:

```powershell
Get-Command ssh.exe
ssh.exe -V
```

From the repository root:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File .\contrib\windows\build-native.ps1

powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File .\contrib\windows\install-native.ps1
```

The build script creates the virtual environment, installs the Windows
dependencies, creates the windowed PyInstaller bundle, and verifies that the
catalog, router package, and schema are present. The installer stages updates
before replacing the current per-user copy and refuses to update while the
installed app is running.

The router package builder canonicalizes its `VERSION` file to LF, so a Windows
CRLF checkout cannot turn an exact companion version such as `0.2.4` into a
mismatched runtime value.

The native installer creates one Desktop shortcut and one current-user Startup
shortcut. The latter opens the app after Windows sign-in, including after a
reboot, without a service or administrator access. Installation remains
idempotent and does not launch the app immediately. It removes an older
same-named Start Menu shortcut, creates no new Start Menu entry, and does not
alter router state.

Launch from the Desktop shortcut or directly:

```powershell
& "$env:LOCALAPPDATA\Programs\Astrill Lazy Router\Astrill Lazy Router.exe"
```

## First-Run SSH Onboarding

Keep the Windows PC and DD-WRT router on a trusted LAN for this one-time flow.
Telnet is unencrypted; never perform the bootstrap across an untrusted network.

In **Settings**:

1. Enter the router host, SSH user and port, and dedicated identity path.
2. Select **Set up key via Telnet**.
3. Independently compare the displayed SSH algorithm and SHA-256 fingerprint
   with the router's trusted record or local console. **Cancel** is the default.
4. Confirm the warning only when the fingerprint matches, then enter the
   one-time Telnet password.
5. Wait until the app reports that strict key-only SSH was verified.

The app scans the SSH endpoint before asking for a credential. After
confirmation it scans again, refuses a changed key, and atomically pins the
confirmed key in its own `known_hosts` file. It generates or reuses a dedicated
Ed25519 identity and uses the LAN Telnet session to append only the public key
material to DD-WRT's existing authorized keys.

The password exists only transiently in app memory. It is not stored in the
configuration, logs, files, command arguments, or environment variables.

The ordering is an important lockout guard:

1. preserve existing authorized keys and append the dedicated public key
   idempotently;
2. restart SSH and prove strict key-only access with Windows OpenSSH;
3. only after that successful proof, disable SSH password authentication,
   SSH forwarding, and WAN SSH;
4. restart SSH and prove key-only access a second time.

Background commands fail closed with batch mode, identity-only
authentication, strict host-key checking, and the app-owned `known_hosts`
file. The onboarding flow never uses `StrictHostKeyChecking=no` and never
silently accepts a new or changed host key.

On Windows, noninteractive OpenSSH helpers such as `ssh.exe`,
`ssh-keyscan.exe`, and `ssh-keygen.exe` run without creating a console window,
so normal status refreshes and onboarding checks do not flash a terminal. The
explicit **Open interactive SSH setup** action intentionally opens a visible
terminal because that action hands control of the SSH session to the user.

Telnet deliberately remains enabled as a recovery path. This is a security
tradeoff: keep it LAN-only and maintain physical or local-console access.

## Services, Policies, And The UU Remote Path

The **Services** view is the safest way to create catalog-backed policies. It
has independent **Category**, **Profile**, and **Provider country** filters in
addition to text search. Provider country describes the service company; it is
not the same thing as choosing an Astrill endpoint country.

Selection is durable while search and filters change. Use any combination of:

- the checkbox at the start of a row;
- normal Qt row selection, including `Ctrl` multi-select and `Shift` range
  selection;
- the tri-state **Select visible** control for the current filtered result; or
- **Clear selection** to clear visible and hidden selections together.

The selected count explicitly reports selections hidden by the current
filters. Choose **Suggested**, **Direct**, or **Astrill**, then select **Add to
Policies**. **Suggested** uses each catalog entry's recommended route; the
other two override the selected services as one batch.

Selection alone does not create a policy. **Add to Policies** writes the
selection to the Windows configuration, and **Apply policies** is a separate,
confirmed router operation. The Policies page reports these two states as
**Local / applied policies**:

- **Local** is the enabled rule count saved in
  `%LOCALAPPDATA%\Astrill Lazy Router\config.json`.
- **Applied** is the origin count reported by the most recent router refresh.
  A dash means that count has not been read yet.

This distinction explains a missing **UU Remote** policy seen during the July
2026 check. The Windows configuration contained no rules, and both the
companion rule table and native router list were empty. The policy therefore
had not been saved or applied; it was not merely hidden by a stale GUI row.

To add it correctly:

1. Open **Policies** and select **Add service...**, or open **Services**.
2. Search for `UU Remote`.
3. Check its row, or select it with the normal row-selection controls.
4. Choose **Suggested**, **Direct**, or **Astrill**.
5. Select **Add to Policies** and confirm that it appears on **Policies**.
6. When the local rule is correct and router writes are intended, select
   **Apply policies** and approve the separate router confirmation.
7. Refresh the router and compare the local and applied counts.

After that workflow was used, the final live readback showed **UU Remote**
saved locally and applied through companion `0.2.4`: one origin, 16 Direct
address rules, zero Astrill/VPN address rules, and zero unresolved domains.
The earlier empty state and this applied state were both real; the difference
was the explicit **Add to Policies** and **Apply policies** actions.

If the row is still absent, inspect the local `rules` array before changing the
router. Do not interpret selecting a catalog row, or merely opening the
Services page, as a saved policy.

## Optional Router Companion

SSH onboarding and companion installation are separate decisions. A successful
fingerprint/Telnet confirmation does not install the companion.

Review native Astrill and router status while the read-only guard is still on.
When the optional DD-WRT companion is wanted, open **Router**, select
**Install / upgrade**, read the write summary, and confirm it separately.
Cancel is the default. On a fresh profile that confirmation also turns off the
local read-only guard; a failed installation restores the guard.

The confirmed installation writes the validated companion package, startup
hook, watchdog, routes, and MyPage entries. It does not change Astrill account
credentials or the selected endpoint. Applying routing policies is another
separately confirmed action; merely editing local policies does not change
traffic.

After a router reboot, the companion's router-local startup hook and watchdog
maintain or reconstruct its runtime from the validated package retained in
NVRAM; this does not depend on desktop polling. The Windows app inspects the
result on its next startup read or manual **Refresh router** action; other
pages load only their own data when first needed. If the router retained
neither the persistent markers nor runtime, the desktop falls back to usable
native-only mode and leaves **Install / upgrade** available. An unreachable
router does not trigger that fallback. Missing, stale, or inconsistent
packages are never silently installed or persistently rewritten.

### Companion 0.2.4 routing and connection fixes

The live router exposed two concrete reliability defects that were separate
from the still-unreproduced 2.4 GHz radio problem.

First, native Astrill had policy rules at priorities `28998` and `28999`, while
the older companion used `29000` and `29001`. Linux evaluates the lower
priority number first, so native Astrill could take precedence before the
companion's marked Direct/Astrill routes. Companion `0.2.4` moves its exact
rules to `28000` and `28001`, ahead of the observed native rules. Its ensure
path validates that precedence and removes only matching old companion entries
at `29000` and `29001`; it does not delete an unrelated rule that happens to
occupy one of those numbers.

Second, the old endpoint-switch path allowed only 30 seconds for Astrill to
become ready. A measured connection from fully down to server `998` using
RouterPro VPN TCP (protocol index `3`) succeeded in 28.4 seconds after the
`0.2.4` upgrade. That endpoint and protocol were valid, but the measured time
left too little margin for normal variation. Endpoint switching now allows 60
seconds and still requires both Astrill's connected state and a `tun0` route
before declaring success. A real timeout restores the previous selection,
stops any late or partial requested tunnel, and then preserves whether the
original endpoint had been connected or disconnected. The Windows SSH timeout
also covers this bounded recovery instead of abandoning it midway. If cleanup
or the prior reconnect cannot be verified, the companion returns a distinct
recovery-failed error rather than claiming restoration.

Router-local maintenance was also reduced. The previous watchdog ensured
runtime every 15 seconds and refreshed domains every five minutes. Version
`0.2.4` ensures every 60 seconds and refreshes every 30 minutes. This lowers
background work on the E4200 while retaining router-local recovery, and does
not introduce desktop SSH polling.

The **Endpoints** page already provides **Connect router to selected endpoint**.
It loads the router's Astrill server catalog, requires the read-only guard to
be off, requires exactly one selected endpoint, and asks for a Cancel-default
confirmation. This action does not install a VPN or change local routing on
the Windows PC.

The connection operation is transactional in both supported modes:

- With the companion enabled, the companion performs the switch, verifies the
  native DD-WRT readback, and restores changed connection settings if the
  switch fails.
- In native-only mode, the app remembers the previous selection and connection
  state, disconnects only when needed, writes the new selection, connects, and
  verifies the readback. A failed attempt restores the previous values and
  reconnects the old session when it had been connected.

### Endpoint filtering, selection, and ordering

The **Country** selector is an exact endpoint-country filter. For example,
selecting one country compares the catalog's complete country name; it does not
use substring matching or accidentally include a similarly named region.
Search can still match endpoint name, country, mapped region, or server ID.

Endpoint selection uses the same durable model as Services: row checkboxes,
`Ctrl`, `Shift`, tri-state **Select visible**, and **Clear selection**. A
selection hidden by search or country filters remains selected and is called
out in the selection summary. Connecting requires exactly one endpoint, while
latency and favorite actions can use a batch.

The sort presets remain **Default order**, **Region (A–Z)**, and **PC latency
(fastest)**. Clicking a table header adds semantic ascending/descending sorts
for Select, Endpoint, Region, Favorite, Server ID, Router state, Nodes, PC
latency, Reach, and Tested. Numeric columns sort as numbers rather than text;
selection and favorite columns sort by actual membership; router state uses
the current/connected state; and latency, reach, and tested use the saved
probe state. Missing values stay at the end in either direction, with the
original Astrill catalog order as the stable tie breaker. Sorting and
filtering preserve selections and never run a test.

### Atomic bulk router favorites

The **Favorite** column is backed by DD-WRT's native `astrill_favlist`. The app
reads it after the endpoint catalog loads, on **Sync from router**, and from
completed-action readbacks. These reads are event-driven; there is no recurring
favorite or router-status poll.

To change favorites:

1. Turn off the read-only guard only when router writes are intended.
2. Load **Endpoints**, select **Sync from router**, then select one or more
   endpoint rows.
3. For additions, choose a protocol supported by every selected endpoint and
   select **Favorite selected**. For removals, select **Unfavorite selected**;
   removal matches only the server ID and does not depend on protocol.
4. Review the Cancel-default batch summary, approve it, and wait for the
   verified DD-WRT readback.

The entire addition is validated before any write, so one endpoint lacking the
chosen protocol blocks the batch. A confirmed batch then:

1. reads the complete favorite value once;
2. preserves existing and unrecognized records and their order;
3. appends only new selections in selected order, or removes only the selected
   server IDs;
4. compares the fresh value before writing;
5. commits at most once; and
6. reads back and verifies the exact result.

A no-op makes no commit. Malformed data, a concurrent favorite change, or any
validation error stops before overwrite and asks for a fresh sync. Favorite
actions are also disabled while the **Astrill** or **Connection** page has
unsaved edits.
Changing favorites does not require the companion, reconnect or switch the
active tunnel, run a latency test, change Windows routing, or start background
monitoring.

### Persistent, manual PC latency

The separate **Test PC latency** action operates on selected endpoints,
currently visible endpoints, or all loaded endpoints. It performs bounded TCP
connection checks from the Windows PC and reports connection setup latency.
The test never starts automatically: opening the page, loading or filtering
the catalog, changing protocol, sorting, and refreshing status do not launch
it.

This PC-side check sends no SSH command to DD-WRT, does not read or write router
configuration, and does not connect or switch the router tunnel. It is not a
VPN throughput or download-speed test; it measures only TCP connection setup
over the PC's current network path, which can differ from the path used by the
router.

The results persist across app restarts in a separate validated local cache;
loading them never starts a network test. Each row keeps its tested time.
Results older than 24 hours, or results whose advertised Astrill address or
port changed, are marked for a manual retest. **Clear results** removes the
cache.

### Reboot and automatic connection behavior

There are two independent autostart settings:

- The Windows Startup shortcut opens the GUI after Windows sign-in. It does not
  connect a local VPN, poll the router repeatedly, or replace the router's own
  startup behavior.
- **Start automatically after router boot** writes native Astrill's
  `astrill_autostart` preference. If it is off, a valid and reachable saved
  endpoint can still remain disconnected after a router reboot; that expected
  state is not evidence that endpoint switching failed.

**Auto reconnect to next favorite server** controls native favorite failover.
The companion's router-local startup hook and watchdog can reconstruct its own
runtime after DD-WRT reboots without the desktop. Neither mechanism justifies
a desktop polling loop.

During the July 2026 inspection, the tunnel was down because native Astrill
autostart was disabled. Its saved endpoint and protocol were valid and
reachable, and no post-boot connection attempt had reached the companion. That
snapshot therefore did not demonstrate a failed endpoint connection. Use the
app's **Start automatically after router boot** control and verify its router
readback when automatic reconnection is wanted.

After the controlled 28.4-second connection test, the user-requested final
state was restored and verified: disconnected, `astrill_autostart=0`, no
`tun0`, and no Astrill OpenVPN process. The saved endpoint remained intact and
the applied UU Remote policy still reported one origin and 16 Direct address
rules. Disconnecting the tunnel therefore did not remove the policy, and the
disabled autostart will not silently reconnect it after the next router boot.

## E4200 2.4 GHz Deep Check

A read-only check was performed after reports that an E4200 v1 sometimes lost
2.4 GHz service and became hard to manage. It did not reproduce the failure.
The router had recently rebooted, and syslog, kernel logging, and remote
logging were all disabled, so the evidence needed to determine the previous
failure's root cause no longer existed.

At inspection time, the DD-WRT r62374 router showed:

- healthy CPU, memory, connection tracking, NVRAM space, file-descriptor use,
  and approximately 54/52 C radio temperatures;
- both radios up with strong associated clients and zero packet loss in the
  wired management ping sample;
- no current OOM, kernel, or radio error in the available runtime output;
- conservative 2.4 GHz AP settings: fixed channel 6, 20 MHz width, WMM on,
  no-ack off, frameburst and afterburner off, beacon 100, DTIM 1, automatic
  protection, and AES; and
- at the initial radio inspection, a healthy, low-load companion with no
  wireless-control (`wl`) commands; its then-zero policy count matched the
  empty Windows configuration.

The check therefore did not implicate the desktop app or companion, but one
healthy snapshot also cannot prove the intermittent radio path is sound. Both
bands were manually configured for 100 mW, the driver reported an unusual
power ceiling, and frame counters were high. The 5 GHz counters were worse,
however, so none of those observations establishes the 2.4 GHz root cause.
Power-supply sag from an aging 12 V / 2 A adapter remains plausible but
unproven.

Use staged diagnostics rather than a broad reset:

1. Test a known-good, regulated 12 V / 2 A supply with the correct connector
   and polarity, keep the router ventilated, and observe whether the symptom
   recurs.
2. Send syslog and kernel log to a separate LAN collector so the next failure
   survives a reboot. Avoid sustained logging to JFFS/flash.
3. Capture radio association, error counters, load, memory, temperatures, and
   wired reachability during the failure before restarting anything.
4. If power and logs do not identify the cause, A/B test one setting at a time:
   return transmit power to Auto/default or 71 mW first. Preserve the prior
   value and test long enough to compare.
5. Only as a later isolated test, disable 2.4 GHz APSD while keeping WMM on.

The evidence did not justify a firmware flash, NVRAM erase, scheduled reboot,
watchdog restart loop, simultaneous radio retune, or speculative permanent
mutation, and none was made during the check. Consider firmware or broader
radio changes only after logs capture a repeatable fault and a rollback/export
path is ready.

## Update Or Remove

Close the app before an update, rebuild, and run `install-native.ps1` again.
To uninstall the application:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File .\contrib\windows\uninstall-native.ps1
```

Uninstall removes the app folder and matching Desktop, Startup, and legacy
Start Menu shortcuts but preserves unrelated shortcuts, configuration, and SSH
keys. Review and remove retained configuration or keys manually only when they
are no longer needed.

The canonical, more detailed reference remains
[docs/WINDOWS_APP.md](https://github.com/lachlanchen/astrill-lazy-router/blob/main/docs/WINDOWS_APP.md)
in the Astrill Lazy Router repository.
