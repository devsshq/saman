import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

// Password prompt for a polkit authentication request.
// Enter submits, Escape cancels.
Overlay {
    id: root

    property var flow: null

    readonly property bool ready: flow ? flow.isResponseRequired : false
    readonly property string iconPath: (flow && flow.iconName) ? Quickshell.iconPath(flow.iconName, true) : ""
    readonly property string notice: !flow ? ""
        : flow.supplementaryMessage !== "" ? flow.supplementaryMessage
        : flow.failed ? "Authentication failed. Try again." : ""
    readonly property bool noticeIsError: flow ? (flow.supplementaryIsError || flow.failed) : false

    title: "Authentication required"

    function submit() {
        if (!ready)
            return;
        flow.submit(input.text);
        input.text = "";
    }

    onDismissed: if (flow) flow.cancelAuthenticationRequest()
    onReadyChanged: if (ready) input.forceActiveFocus()
    onVisibleChanged: if (visible) Qt.callLater(() => input.forceActiveFocus())

    Connections {
        target: root.flow
        function onAuthenticationFailed() {
            input.text = "";
        }
    }

    RowLayout {
        width: parent.width
        spacing: 12

        IconImage {
            visible: root.iconPath !== ""
            source: root.iconPath
            implicitSize: 32
            Layout.alignment: Qt.AlignTop
        }

        Text {
            Layout.fillWidth: true
            text: root.flow ? root.flow.message : ""
            wrapMode: Text.WordWrap
            color: Theme.fgDim
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }
    }

    // only shown when more than one identity may authenticate
    Row {
        visible: root.flow ? root.flow.identities.length > 1 : false
        spacing: 8

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "As"
            color: Theme.muted
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }

        Repeater {
            model: root.flow ? root.flow.identities : []

            delegate: Button {
                required property var modelData

                text: modelData.displayName
                active: root.flow && root.flow.selectedIdentity === modelData
                onClicked: root.flow.selectedIdentity = modelData
            }
        }
    }

    Rectangle {
        width: parent.width
        height: 36
        color: Theme.surface
        border.width: 2
        border.color: root.noticeIsError ? Theme.error : input.activeFocus ? Theme.accent : Theme.line

        TextInput {
            id: input
            anchors { fill: parent; leftMargin: 10; rightMargin: 10 }
            verticalAlignment: TextInput.AlignVCenter
            clip: true
            readOnly: !root.ready
            echoMode: (root.flow && root.flow.responseVisible) ? TextInput.Normal : TextInput.Password
            passwordCharacter: "•"
            color: Theme.fg
            selectionColor: Theme.accentDim
            selectedTextColor: Theme.fg
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            onAccepted: root.submit()

            Text {
                anchors.verticalCenter: parent.verticalCenter
                visible: input.text === ""
                text: root.flow ? root.flow.inputPrompt.replace(/:\s*$/, "") : ""
                color: Theme.muted
                font: input.font
            }
        }
    }

    Text {
        width: parent.width
        visible: root.notice !== ""
        text: root.notice
        wrapMode: Text.WordWrap
        color: root.noticeIsError ? Theme.error : Theme.fgDim
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize - 1
    }

    Item {
        width: parent.width
        height: buttons.height

        Row {
            id: buttons
            anchors.right: parent.right
            spacing: 12

            Button {
                text: "Cancel"
                onClicked: root.dismissed()
            }

            Button {
                text: "Authenticate"
                active: root.ready
                onClicked: root.submit()
            }
        }
    }
}
