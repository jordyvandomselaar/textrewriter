import SwiftUI
import AppKit

struct KeyboardShortcutRecorder: View {
    @Binding var shortcut: AppKeyboardShortcut
    @State private var isRecording = false
    @State private var localMonitor: Any?
    let defaultShortcut: AppKeyboardShortcut
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(shortcut.name)
                .font(.headline)
            
            HStack {
                Text(String(describing: shortcut))
                    .frame(minWidth: 100)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(isRecording ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                    )
                
                Button(isRecording ? "Cancel" : "Record") {
                    if isRecording {
                        stopRecording()
                    } else {
                        startRecording()
                    }
                }
                
                Button("Reset") {
                    shortcut = defaultShortcut
                }
            }
        }
        .onDisappear {
            stopRecording()
        }
    }
    
    private func startRecording() {
        isRecording = true
        
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown]) { event in
            handleKeyEvent(event)
            return nil
        }
    }
    
    private func stopRecording() {
        isRecording = false
        if let monitor = localMonitor {
            NSEvent.removeMonitor(monitor)
            localMonitor = nil
        }
    }
    
    private func handleKeyEvent(_ event: NSEvent) {
        // Ignore standalone modifier key presses
        guard !isModifierKey(event.keyCode) else { return }
        
        shortcut = AppKeyboardShortcut(
            name: shortcut.name,
            keyCode: UInt16(event.keyCode),
            modifierFlags: event.modifierFlags.intersection([.command, .option, .shift, .control])
        )
        
        stopRecording()
    }
    
    private func isModifierKey(_ keyCode: UInt16) -> Bool {
        // Common modifier key codes
        let modifierKeyCodes: Set<UInt16> = [54, 55, 56, 57, 58, 59, 60, 61, 62, 63]
        return modifierKeyCodes.contains(keyCode)
    }
} 