import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

RowLayout {
    id: root

    readonly property var current: ToplevelManager.activeToplevel
    readonly property var entry: (current && current.appId) ? DesktopEntries.heuristicLookup(current.appId) : null
    readonly property string icon: entry ? Quickshell.iconPath(entry.icon, true) : ""

    visible: !!current && current.title !== ""
    spacing: 8
    Layout.leftMargin: 12
    Layout.maximumWidth: 600

    IconImage {
        visible: root.icon !== ""
        source: root.icon
        implicitSize: 20
    }

    Text {
        Layout.fillWidth: true
        text: root.current ? root.current.title : ""
        elide: Text.ElideRight
        color: Theme.fg
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }
}
