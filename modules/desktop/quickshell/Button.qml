import QtQuick

Rectangle {
    id: root

    property string text: ""
    property bool active: false
    property color tone: Theme.accent

    signal clicked()
    signal hovered()

    width: label.implicitWidth + 32
    height: 32
    color: active ? Theme.accentDim : "transparent"
    border.width: 2
    border.color: active ? tone : Theme.line

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: root.active ? Theme.fg : Theme.fgDim
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered()
        onClicked: root.clicked()
    }
}
