# Recover internet access after a FortiGate session quota block

If the browser says **“Traffic blocked because of exceeded session quota”**,
check connection pressure before changing DNS, resetting the browser or buying
more API credits. On October 11, 2026, normal internet access recovered after
stopping one project-owned browser desktop. Its launcher was then changed to
open only the page needed for the current task.

This is a recovered incident and a local prevention fix, not a change to the
upstream firewall policy.

## What the message means

Fortinet documents this exact message for a FortiGate **per-IP concurrent
session limit**. It limits simultaneous network sessions, not Codex tokens or
a monthly download allowance. A network administrator can inspect the relevant
per-IP shaper and its `max-concurrent-session` setting. A displayed quota of
zero alone does not establish the firewall's actual configuration.
[Fortinet troubleshooting reference](https://community.fortinet.com/fortigate-3/troubleshooting-tip-traffic-blocked-because-of-exceeded-session-quota-on-traffic-shaper-174199).

## What was observed

- Browser connectivity detection showed the quota message, and Apple requests
  timed out.
- The promotion launcher reopened about 29 old social, mail, affiliate and
  research tabs. Its Chrome network process owned 38 public TCP connections.
- A separate Windows VM had over 100 half-closed `FIN-WAIT-2` connections;
  sampled idle times exceeded 25 hours. Those local sockets do not prove the
  upstream firewall still counted them. The VM was not interrupted.
- After stopping only the promotion project's desktop, the connectivity probe
  returned HTTP 204 and Apple requests succeeded. A later one-tab browser test
  loaded the actual App Store page with HTTP 200 and no quota message.

The timing supports reducing connection pressure as a useful mitigation. It
does not prove this browser was the sole cause, or reveal every device sharing
the firewall's source IP.

## Safe diagnosis on a shared Linux workstation

These checks are read-only. Socket output can contain private destinations and
process details; inspect it locally rather than posting the raw output.

```bash
free -h
ip route show default
ss -s
ss -tanH | awk '{count[$1]++} END {for (state in count) print state, count[state]}'
ss -tanpi state fin-wait-2
tmux list-sessions
```

Use `ps -p PID -o pid,etime,args` and `/proc/PID/cwd` to establish ownership
before stopping a process. Some socket ownership requires administrator
visibility. Lack of visible owners is not permission to terminate everything.

Probe one known endpoint with a timeout, then the site that originally failed:

```bash
curl --max-time 12 --silent --show-error --output /dev/null \
  --write-out 'HTTP %{http_code}; elapsed %{time_total}s\n' \
  http://connectivitycheck.gstatic.com/generate_204
```

An ordinary successful response here is HTTP 204. It is a connectivity check,
not proof that every HTTPS destination or browser session works.

## Local recovery and prevention

1. Save the current project's review evidence and permitted workspace links.
2. Stop only that project's idle browser or other confirmed obsolete runtime,
   using its ownership-aware launcher.
3. Retry the small connectivity probe and the original destination. Do not
   launch a parallel batch of tests while the network is under pressure.
4. Start one project browser with one required tab and verify it works.
5. Stop it again when no user review is waiting.

LazyPromotion now defaults to `about:blank`. For a focused review, run from
that project's root:

```bash
LAZYPROMOTION_START_URL=https://platform.postiz.com/launches scripts/desktop.sh start
scripts/desktop.sh status
scripts/desktop.sh stop
```

The profile and logins remain intact. Saving merges and deduplicates allowed
URLs in a private archive instead of replacing it with an empty session.
Restoring the old full workspace is explicitly opt-in through
`LAZYPROMOTION_RESTORE_WORKSPACE=1`; avoid it for routine checks. Startup
settings are passed explicitly to tmux so an old server environment cannot
silently override the requested page.

The associated MCP endpoint was also corrected to the project's own browser.
That prevents cross-project attachment; it is separate from the network cause.
The fix passed 246 focused tests, shell syntax checks and a live one-tab Apple
page check. The saved workspace checksum was unchanged before and after the
test. [LazyPromotion implementation](https://github.com/lachlanchen/LazyPromotion/commit/571027b180c30bd90068d865b86788e9fa1e743e).

## If the block returns

Ask the network administrator to inspect the firewall's per-IP session count,
drop counters, source sharing and shaping policy. The owner of a VM with stale
connections can separately inspect its applications and networking. Do not
assume every `FIN-WAIT-2` socket is abandoned or safe to destroy.

Do not reboot a shared router, flush connection tables, kill unrelated VMs,
reset browser profiles, switch source IPs or use a VPN to evade the quota.
Fortinet's example limit is not a suitable value to copy blindly into another
network. The October 11 repair changed no firewall, route, DNS or VM settings.

Raw socket snapshots, private URLs, screenshots and machine-specific receipts
stay outside the public repository.
