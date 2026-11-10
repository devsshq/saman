import QtQuick
import Quickshell
import Quickshell.I3
import Quickshell.Wayland

// Fullscreen dimmed layer with a centered card and exclusive keyboard focus.
// Children are placed inside the card, below the title.
PanelWindow {
    id: root

    property string title: ""
    default property alias content: body.data

    signal dismissed()
    signal keyPressed(var event)

    screen: Quickshell.screens.find(s => s.name === I3.focusedMonitor?.name) ?? Quickshell.screens[0]
    anchors { top: true; bottom: true; left: true; right: true }
    exclusionMode: ExclusionMode.Ignore
    color: Qt.rgba(0, 0, 0, 0.6)

    WlrLayershell.namespace: "saman-overlay"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    FocusScope {
        anchors.fill: parent
        focus: true

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.dismissed();
                event.accepted = true;
            } else {
                root.keyPressed(event);
            }
        }

        // click outside the card
        MouseArea {
            anchors.fill: parent
            onClicked: root.dismissed()
        }

        Rectangle {
            anchors.centerIn: parent
            width: 420
            height: column.implicitHeight + 40
            color: Theme.bg
            border.width: 2
            border.color: Theme.line

            // swallow clicks on the card
            MouseArea { anchors.fill: parent }

            Column {
                id: column
                anchors { fill: parent; margins: 20 }
                spacing: 16

                Text {
                    visible: root.title !== ""
                    text: root.title
                    color: Theme.accent
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize + 2
                    font.bold: true
                }

                Column {
                    id: body
                    width: parent.width
                    spacing: 12
                }
            }
        }
    }
}
