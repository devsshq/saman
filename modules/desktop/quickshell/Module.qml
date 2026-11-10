import QtQuick

// A text item in the bar with hover and mouse handling
Rectangle {
    id: root

    property string text: ""
    property color textColor: Theme.fg
    property bool hoverable: true

    signal clicked(var mouse)
    signal scrolled(int delta)

    implicitWidth: label.implicitWidth + 24
    implicitHeight: 28
    color: hoverable && area.containsMouse ? Theme.surface : "transparent"

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: root.hoverable && area.containsMouse ? Theme.accent : root.textColor
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onClicked: mouse => root.clicked(mouse)
        onWheel: wheel => root.scrolled(wheel.angleDelta.y)
    }
}
