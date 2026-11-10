import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: bar

    required property var modelData
    screen: modelData

    anchors { top: true; left: true; right: true }
    implicitHeight: 36
    color: Theme.bg

    // bottom border
    Rectangle {
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
        height: 2
        color: Theme.line
    }

    RowLayout {
        anchors { left: parent.left; leftMargin: 6; verticalCenter: parent.verticalCenter }
        spacing: 2

        Workspaces {}
        Mode {}
        Divider {}
        WindowTitle {}
    }

    Clock { anchors.centerIn: parent }

    RowLayout {
        anchors { right: parent.right; rightMargin: 6; verticalCenter: parent.verticalCenter }
        spacing: 2

        Tray { bar: bar; Layout.rightMargin: 8 }
        Divider {}
        Backlight {}
        Mic {}
        Volume {}
        Network {}
        Battery {}
    }
}
