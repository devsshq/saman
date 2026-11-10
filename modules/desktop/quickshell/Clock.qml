import QtQuick
import Quickshell

Text {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "HH:mm")
    color: Theme.fg
    font.family: Theme.fontFamily
    font.pixelSize: 14
    font.bold: true
}
