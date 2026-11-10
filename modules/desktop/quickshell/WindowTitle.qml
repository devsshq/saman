import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Text {
    readonly property var current: ToplevelManager.activeToplevel

    text: current ? current.title : ""
    visible: text !== ""
    elide: Text.ElideRight
    leftPadding: 12
    color: Theme.fg
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSize
    Layout.maximumWidth: 600
}
