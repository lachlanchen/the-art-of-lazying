import Foundation
import Carbon

// List, inspect, or select macOS keyboard input sources through the native
// Text Input Source API. Run with `swift macos-input-source.swift ...`.

func stringProperty(_ source: TISInputSource, _ key: CFString) -> String? {
    guard let raw = TISGetInputSourceProperty(source, key) else {
        return nil
    }
    return Unmanaged<CFString>.fromOpaque(raw).takeUnretainedValue() as String
}

func boolProperty(_ source: TISInputSource, _ key: CFString) -> Bool {
    guard let raw = TISGetInputSourceProperty(source, key) else {
        return false
    }
    return CFBooleanGetValue(
        Unmanaged<CFBoolean>.fromOpaque(raw).takeUnretainedValue()
    )
}

func describe(_ source: TISInputSource) -> String {
    let id = stringProperty(source, kTISPropertyInputSourceID) ?? ""
    let name = stringProperty(source, kTISPropertyLocalizedName) ?? ""
    let mode = stringProperty(source, kTISPropertyInputModeID) ?? ""
    let enabled = boolProperty(source, kTISPropertyInputSourceIsEnabled)
    let selectable = boolProperty(source, kTISPropertyInputSourceIsSelectCapable)
    return "id=\(id)\tname=\(name)\tmode=\(mode)\tenabled=\(enabled)\tselectable=\(selectable)"
}

let arguments = CommandLine.arguments

if arguments.count == 1 || arguments[1] == "list" {
    let sources = TISCreateInputSourceList(nil, true).takeRetainedValue()
    for index in 0..<CFArrayGetCount(sources) {
        let source = unsafeBitCast(
            CFArrayGetValueAtIndex(sources, index),
            to: TISInputSource.self
        )
        if boolProperty(source, kTISPropertyInputSourceIsEnabled) {
            print(describe(source))
        }
    }
    exit(0)
}

if arguments[1] == "current" {
    let source = TISCopyCurrentKeyboardInputSource().takeRetainedValue()
    print(describe(source))
    exit(0)
}

if arguments[1] == "select", arguments.count == 3 {
    let wanted = arguments[2]
    let filter = [kTISPropertyInputSourceID: wanted] as CFDictionary
    let sources = TISCreateInputSourceList(filter, true).takeRetainedValue()
    guard CFArrayGetCount(sources) > 0 else {
        fputs("Input source not found: \(wanted)\n", stderr)
        exit(2)
    }
    let source = unsafeBitCast(
        CFArrayGetValueAtIndex(sources, 0),
        to: TISInputSource.self
    )
    let result = TISSelectInputSource(source)
    if result != noErr {
        fputs("TISSelectInputSource failed: \(result)\n", stderr)
        exit(3)
    }
    print(describe(TISCopyCurrentKeyboardInputSource().takeRetainedValue()))
    exit(0)
}

fputs("Usage: macos-input-source.swift [list|current|select INPUT_SOURCE_ID]\n", stderr)
exit(64)
