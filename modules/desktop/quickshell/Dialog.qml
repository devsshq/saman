import QtQuick

// Confirmation dialog. Enter confirms the selected button, Escape cancels.
Overlay {
    id: root

    property string message: ""
    property string confirmText: "Confirm"
    property string cancelText: "Cancel"
    property bool danger: false

    // 0 = cancel, 1 = confirm
    property int selected: 1

    signal accepted()

    onVisibleChanged: if (visible) selected = 1

    onKeyPressed: event => {
        switch (event.key) {
        case Qt.Key_Left:
        case Qt.Key_Right:
        case Qt.Key_Tab:
        case Qt.Key_Backtab:
        case Qt.Key_H:
        case Qt.Key_L:
            selected = 1 - selected;
            break;
        case Qt.Key_Return:
        case Qt.Key_Enter:
            if (selected === 1)
                accepted();
            else
                dismissed();
            break;
        default:
            return;
        }
        event.accepted = true;
    }

    Text {
        width: parent.width
        visible: root.message !== ""
        text: root.message
        wrapMode: Text.WordWrap
        color: Theme.fgDim
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }

    Item {
        width: parent.width
        height: buttons.height

        Row {
            id: buttons
            anchors.right: parent.right
            spacing: 12

            Repeater {
                model: [root.cancelText, root.confirmText]

                delegate: Rectangle {
                    id: button
                    required property int index
                    required property string modelData

                    readonly property bool active: root.selected === index

                    width: label.implicitWidth + 32
                    height: 32
                    color: active ? Theme.accentDim : "transparent"
                    border.width: 2
                    border.color: !active ? Theme.line
                                : (index === 1 && root.danger) ? Theme.error : Theme.accent

                    Text {
                        id: label
                        anchors.centerIn: parent
                        text: button.modelData
                        color: button.active ? Theme.fg : Theme.fgDim
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: root.selected = button.index
                        onClicked: button.index === 1 ? root.accepted() : root.dismissed()
                    }
                }
            }
        }
    }
}
