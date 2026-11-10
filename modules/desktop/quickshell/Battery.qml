import QtQuick
import Quickshell.Services.UPower

Module {
    id: root

    readonly property var dev: UPower.displayDevice
    readonly property int percent: Math.round((dev?.percentage ?? 0) * 100)
    readonly property bool charging: dev !== null && (
        dev.state === UPowerDeviceState.Charging
        || dev.state === UPowerDeviceState.FullyCharged
        || dev.state === UPowerDeviceState.PendingCharge)

    visible: dev?.isPresent ?? false
    textColor: charging ? Theme.success
             : percent <= 20 ? Theme.error
             : percent <= 30 ? Theme.warning : Theme.fg
    text: (charging ? Icons.batteryCharging : Icons.battery[Math.min(10, Math.round(percent / 10))])
        + " " + percent + "%"
}
