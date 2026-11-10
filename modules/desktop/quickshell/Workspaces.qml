import QtQuick
import Quickshell
import Quickshell.I3

Row {
    spacing: 4

    Repeater {
        model: ScriptModel {
            values: Array.from(I3.workspaces.values).sort((a, b) => a.number - b.number)
        }

        delegate: Rectangle {
            id: ws
            required property var modelData

            implicitWidth: label.implicitWidth + 20
            implicitHeight: 28
            color: modelData.urgent ? Theme.error
                 : modelData.focused ? Theme.accentDim
                 : area.containsMouse ? Theme.surface : "transparent"
            border.width: 2
            border.color: modelData.focused && !modelData.urgent ? Theme.accent : "transparent"

            Text {
                id: label
                anchors.centerIn: parent
                text: ws.modelData.name
                color: ws.modelData.urgent ? Theme.bg
                     : (ws.modelData.focused || area.containsMouse) ? Theme.fg : Theme.muted
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
            }

            MouseArea {
                id: area
                anchors.fill: parent
                hoverEnabled: true
                onClicked: ws.modelData.activate()
            }
        }
    }
}
