import QtQuick
import Quickshell
import Quickshell.Io

Module {
    id: root

    property int percent: 0

    text: Icons.brightness[Math.min(2, Math.floor(percent / 34))] + " " + percent + "%"

    Process {
        id: reader
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            id: out
            onStreamFinished: {
                // device,class,current,percent%,max
                const f = out.text.trim().split(",");
                if (f.length >= 4)
                    root.percent = parseInt(f[3]);
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: reader.running = true
    }

    onScrolled: delta => {
        Quickshell.execDetached(["brightnessctl", "set", delta > 0 ? "10%+" : "10%-"]);
        reader.running = true;
    }
}
