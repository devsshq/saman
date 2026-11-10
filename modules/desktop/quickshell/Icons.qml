pragma Singleton
import QtQuick
import Quickshell

// Nerd Font (Material Design) glyphs, by code point
Singleton {
    function g(cp) { return String.fromCodePoint(cp); }

    readonly property var brightness: [g(0xF00DE), g(0xF00DF), g(0xF00E0)]
    readonly property var volume: [g(0xF057F), g(0xF0580), g(0xF057E)]
    readonly property string volumeMuted: g(0xF075F)
    readonly property string mic: g(0xF036C)
    readonly property string micMuted: g(0xF036D)
    readonly property string wifi: g(0xF05A9)
    readonly property string wifiOff: g(0xF05AA)
    readonly property string ethernet: g(0xF0200)
    readonly property var battery: [
        g(0xF008E), g(0xF007A), g(0xF007B), g(0xF007C), g(0xF007D), g(0xF007E),
        g(0xF007F), g(0xF0080), g(0xF0081), g(0xF0082), g(0xF0079)
    ]
    readonly property string batteryCharging: g(0xF0084)
    readonly property string power: g(0xF0425)
    readonly property string restart: g(0xF0709)
    readonly property string logout: g(0xF0343)
}
