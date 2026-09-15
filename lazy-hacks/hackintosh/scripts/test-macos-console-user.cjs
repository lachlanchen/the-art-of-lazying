const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const source = fs.readFileSync(path.join(__dirname, 'macos-console-user.js'), 'utf8');
function resolve(name, failure = false) {
    const context = vm.createContext({
        ObjC: { import() {}, unwrap: value => value, castRefToObject: value => value },
        $: { SCDynamicStoreCopyConsoleUser() {
            if (failure) throw new Error('unavailable');
            return name;
        } },
    });
    vm.runInContext(source, context);
    return context.run();
}

assert.equal(resolve('lachlan'), 'lachlan');
assert.equal(resolve('another.user'), 'another.user');
for (const name of [null, undefined, '', 'root', 'loginwindow', '_mbsetupuser', 'bad\nname']) {
    assert.equal(resolve(name), 'none');
}
assert.equal(resolve('lachlan', true), 'none');
const watchdog = fs.readFileSync(path.join(__dirname, 'macos-uuremote-unattended-watchdog.sh'), 'utf8');
assert.ok(watchdog.includes('run_with_timeout 5 /usr/bin/osascript'));
assert.ok(watchdog.includes('[ "$connection_count" -gt 0 ] &&'));
assert.ok(!watchdog.includes("stat -f '%Su' /dev/console"));
console.log('Console-user and host-agent health regression checks passed');
