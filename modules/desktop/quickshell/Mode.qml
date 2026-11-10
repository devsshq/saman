import QtQuick
import Quickshell.I3

Module {
    id: root

    property string mode: "default"

    visible: mode !== "default"
    hoverable: false
    text: mode
    textColor: Theme.warning

    I3IpcListener {
        subscriptions: ["mode"]
        onIpcEvent: event => {
            try {
                root.mode = JSON.parse(event.data).change;
            } catch (e) {}
        }
    }
}
