function run() {
    ObjC.import("SystemConfiguration");
    try {
        // /dev/console ownership can be stale after remote console transitions.
        var ref = $.SCDynamicStoreCopyConsoleUser(null, null, null);
        var name = ObjC.unwrap(ObjC.castRefToObject(ref));
        if (typeof name !== "string" || !name || /[\r\n]/.test(name) ||
            ["root", "loginwindow", "_mbsetupuser"].indexOf(name) !== -1) {
            return "none";
        }
        return name;
    } catch (error) {
        return "none";
    }
}
