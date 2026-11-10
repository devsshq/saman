import QtQuick
import Quickshell
import Quickshell.Services.Polkit

// Polkit authentication agent for this session
Scope {
    PolkitAgent {
        id: agent
    }

    PolkitPrompt {
        visible: agent.isActive
        flow: agent.flow
    }
}
