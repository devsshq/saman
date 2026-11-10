import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Row {
    id: root

    required property var bar
    spacing: 10

    Repeater {
        model: SystemTray.items

        delegate: MouseArea {
            id: item
            required property var modelData

            width: 20
            height: 20
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

            onClicked: mouse => {
                if (mouse.button === Qt.MiddleButton) {
                    modelData.secondaryActivate();
                } else if (mouse.button === Qt.LeftButton && !modelData.onlyMenu) {
                    modelData.activate();
                } else if (modelData.hasMenu) {
                    const p = item.mapToItem(null, 0, item.height);
                    modelData.display(root.bar, p.x, p.y);
                }
            }

            IconImage {
                anchors.fill: parent
                source: item.modelData.icon
            }
        }
    }
}
