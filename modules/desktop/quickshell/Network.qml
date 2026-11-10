import QtQuick
import Quickshell.Io

Module {
    id: root

    property string kind: "none" // wifi | ethernet | none
    property string ssid: ""
    property int strength: 0

    textColor: kind === "none" ? Theme.error : Theme.fg
    text: kind === "wifi" ? Icons.wifi + " " + ssid + "  " + strength + "%"
        : kind === "ethernet" ? Icons.ethernet + " Wired"
        : Icons.wifiOff + " Disconnected"

    function parse(s) {
        const parts = s.split("---\n");
        const devices = parts[0].split("\n");
        const active = (parts[1] || "").split("\n").find(l => l.startsWith("*:"));

        if (active) {
            // IN-USE:SIGNAL:SSID, with ":" in the SSID escaped as "\:"
            const f = active.split(":");
            kind = "wifi";
            strength = parseInt(f[1]);
            ssid = f.slice(2).join(":").replace(/\\:/g, ":");
        } else if (devices.some(l => l.startsWith("ethernet:connected"))) {
            kind = "ethernet";
        } else {
            kind = "none";
        }
    }

    Process {
        id: reader
        command: ["sh", "-c", "nmcli -t -f TYPE,STATE device; echo ---; nmcli -t -f IN-USE,SIGNAL,SSID device wifi list --rescan no"]
        stdout: StdioCollector {
            id: out
            onStreamFinished: root.parse(out.text)
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: reader.running = true
    }
}
