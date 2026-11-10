import QtQuick
import Quickshell
import Quickshell.I3
import Quickshell.Io

// Session actions: exit confirmation and power menu, driven over IPC:
//   qs ipc -c saman call session confirmExit
//   qs ipc -c saman call session menu
Scope {
    id: root

    property bool confirmingExit: false
    property bool menuOpen: false

    IpcHandler {
        target: "session"

        function confirmExit(): void {
            root.menuOpen = false;
            root.confirmingExit = true;
        }

        function menu(): void {
            root.confirmingExit = false;
            root.menuOpen = true;
        }
    }

    Dialog {
        visible: root.confirmingExit
        title: "Exit sway?"
        message: "This ends your session. Unsaved work in open windows will be lost."
        confirmText: "Exit"
        danger: true

        onAccepted: {
            root.confirmingExit = false;
            I3.dispatch("exit");
        }
        onDismissed: root.confirmingExit = false
    }

    PowerMenu {
        visible: root.menuOpen

        onDismissed: root.menuOpen = false
        onChosen: action => {
            root.menuOpen = false;
            if (action === "shutdown")
                Quickshell.execDetached(["systemctl", "poweroff"]);
            else if (action === "restart")
                Quickshell.execDetached(["systemctl", "reboot"]);
            else if (action === "logout")
                root.confirmingExit = true;
        }
    }
}
