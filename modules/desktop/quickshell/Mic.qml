import QtQuick
import Quickshell.Services.Pipewire

Module {
    id: root

    readonly property var node: Pipewire.defaultAudioSource
    readonly property bool muted: node?.audio?.muted ?? false
    readonly property int percent: Math.round((node?.audio?.volume ?? 0) * 100)

    PwObjectTracker { objects: [root.node] }

    visible: node !== null
    textColor: muted ? Theme.muted : Theme.fg
    text: muted ? Icons.micMuted + " Muted" : Icons.mic + " " + percent + "%"

    onClicked: mouse => {
        if (node?.audio)
            node.audio.muted = !node.audio.muted;
    }

    onScrolled: delta => {
        if (!node?.audio)
            return;
        const v = node.audio.volume + (delta > 0 ? 0.05 : -0.05);
        node.audio.volume = Math.max(0, Math.min(1, v));
    }
}
