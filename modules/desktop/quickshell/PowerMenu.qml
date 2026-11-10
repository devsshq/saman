import QtQuick

// Shutdown / Restart / Logout. Arrows, j/k or Tab move; Enter or s/r/l choose.
Overlay {
    id: root

    title: "Power"

    property int current: 0

    signal chosen(string action)

    readonly property var entries: [
        { action: "shutdown", label: "Shutdown", icon: Icons.power,   key: Qt.Key_S, hint: "s" },
        { action: "restart",  label: "Restart",  icon: Icons.restart, key: Qt.Key_R, hint: "r" },
        { action: "logout",   label: "Logout",   icon: Icons.logout,  key: Qt.Key_L, hint: "l" }
    ]

    onVisibleChanged: if (visible) current = 0

    onKeyPressed: event => {
        const n = entries.length;
        if (event.key === Qt.Key_Down || event.key === Qt.Key_J || event.key === Qt.Key_Tab) {
            current = (current + 1) % n;
        } else if (event.key === Qt.Key_Up || event.key === Qt.Key_K || event.key === Qt.Key_Backtab) {
            current = (current + n - 1) % n;
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            chosen(entries[current].action);
        } else {
            const e = entries.find(x => x.key === event.key);
            if (!e)
                return;
            chosen(e.action);
        }
        event.accepted = true;
    }

    Repeater {
        model: root.entries

        delegate: Rectangle {
            id: row
            required property int index
            required property var modelData

            readonly property bool active: root.current === index

            width: parent.width
            height: 40
            color: active ? Theme.accentDim : "transparent"
            border.width: 2
            border.color: active ? Theme.accent : "transparent"

            Text {
                anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
                text: row.modelData.icon + "  " + row.modelData.label
                color: row.active ? Theme.fg : Theme.fgDim
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
            }

            Text {
                anchors { right: parent.right; rightMargin: 14; verticalCenter: parent.verticalCenter }
                text: row.modelData.hint
                color: Theme.muted
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: root.current = row.index
                onClicked: root.chosen(row.modelData.action)
            }
        }
    }
}
