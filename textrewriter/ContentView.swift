import SwiftUI
import AppKit
import Quartz
import KeychainSwift
import LaunchAtLogin

struct ContentView: View {
    @State private var copiedText: String = ""
    @State private var eventMonitor: Any? = nil
    private let keychain = KeychainSwift()
    @AppStorage("systemPrompt") private var systemPrompt: String = ""
    
    // Keyboard shortcuts
    @AppStorage("keyboardShortcutAll") private var shortcutAllData: Data = try! JSONEncoder().encode(AppKeyboardShortcut.defaultAll)
    @AppStorage("keyboardShortcutHighlighted") private var shortcutHighlightedData: Data = try! JSONEncoder().encode(AppKeyboardShortcut.defaultHighlighted)
    
    var openAiApiKey: String {
        return keychain.get("textrewriter_openai_api_key") ?? ""
    }
    
    private var currentShortcutAll: AppKeyboardShortcut {
        (try? JSONDecoder().decode(AppKeyboardShortcut.self, from: shortcutAllData)) ?? .defaultAll
    }
    
    private var currentShortcutHighlighted: AppKeyboardShortcut {
        (try? JSONDecoder().decode(AppKeyboardShortcut.self, from: shortcutHighlightedData)) ?? .defaultHighlighted
    }
    
    var body: some View {
        VStack {
            Text("How to use the app:\n\n1. Press \(currentShortcutAll.description) to reformat all text in the currently focused input box\n2. Press \(currentShortcutHighlighted.description) to reformat only the selected text\n\nThis app copies the text, sends it to OpenAI for correcting grammar, spelling, punctuation, and formatting, and then pastes back the corrected text. Settings: You can update your OpenAI API key, keyboard shortcuts, and the system prompt in the app settings.")
                .multilineTextAlignment(.leading)
                .padding()
            Text("Last reformatted text:") 
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            TextEditor(text: $copiedText)
                .frame(height: 200)
                .textFieldStyle(RoundedBorderTextFieldStyle()) 
                .padding()
        }
        .onAppear {
            // Register global event monitors for both shortcuts
            eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
                if event.modifierFlags.intersection([.command, .option, .shift, .control]) == currentShortcutAll.modifierFlags &&
                    event.keyCode == currentShortcutAll.keyCode {
                    simulateCopyAction(selectAll: true)
                } else if event.modifierFlags.intersection([.command, .option, .shift, .control]) == currentShortcutHighlighted.modifierFlags &&
                    event.keyCode == currentShortcutHighlighted.keyCode {
                    simulateCopyAction(selectAll: false)
                }
            }
        }
        .onDisappear {
            if let monitor = eventMonitor {
                NSEvent.removeMonitor(monitor)
                eventMonitor = nil
            }
        }
    }
    
    // Helper function to simulate a key press event with the Command key
    func simulateShortcut(key: CGKeyCode, modifiers: CGEventFlags = .maskCommand) {
        if let keyDown = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true) {
            keyDown.flags = modifiers
            keyDown.post(tap: .cghidEventTap)
        }
        if let keyUp = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: false) {
            keyUp.flags = modifiers
            keyUp.post(tap: .cghidEventTap)
        }
    }
    
    // Function to simulate copy action with optional select all
    func simulateCopyAction(selectAll: Bool) {
        if selectAll {
            // Simulate CMD+A (select all)
            simulateShortcut(key: 0)  // key code 0 for 'A'
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Simulate CMD+C (copy)
            self.simulateShortcut(key: 8)  // key code 8 for 'C'
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let pasteboard = NSPasteboard.general
                if let copied = pasteboard.string(forType: .string) {
                    self.copiedText = copied
                    // Send the copied text to OpenAI for reformatting
                    Task {
                        await reformatTextWithOpenAI(originalText: copied, selectAll: selectAll)
                    }
                } else {
                    self.copiedText = "No text found"
                }
            }
        }
    }
    
    // Asynchronous function to send a prompt to OpenAI,
    // asking it to reformat the provided text into a legit Slack message.
    func reformatTextWithOpenAI(originalText: String, selectAll: Bool) async {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(openAiApiKey)", forHTTPHeaderField: "Authorization")
        
        let promptText = "\(originalText)"
        let defaultSystemPrompt = "You are a helpful assistant that fixes grammar, spelling, punctuation, and formatting errors in text. Any time you receive a message, you will immediately fix the errors and return the corrected message. You will not add any new text, only fix the errors. If there isn't anything to format, you will return nothing. You will only return the corrected message, nothing else. If there is a way to rewrite the text to convey the same sentiment but in a better or more optimal way, you're allowed to do that."
        
        let finalSystemPrompt = systemPrompt.isEmpty ? defaultSystemPrompt : systemPrompt
        
        // Prepare the request body with the system prompt from AppStorage
        let requestBody: [String: Any] = [
            "model": "gpt-4o",
            "messages": [
                ["role": "system", "content": finalSystemPrompt],
                ["role": "user", "content": promptText]
            ],
            "temperature": 0.7,
            "top_p": 0.8,
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            let (data, _) = try await URLSession.shared.data(for: request)
            // Parse the response to extract the assistant's message.
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let firstChoice = choices.first,
               let message = firstChoice["message"] as? [String: Any],
               let content = message["content"] as? String {
                DispatchQueue.main.async {
                    self.copiedText = content
                    // Update pasteboard with new text
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(content, forType: .string)
                    if(selectAll) {
                        // Simulate CMD+A (select all) then CMD+V (paste) to replace text in the focused input box
                        self.simulateShortcut(key: 0)  // CMD+A
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.simulateShortcut(key: 9)  // CMD+V (key code 9 for 'V')
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.copiedText = "Failed to parse OpenAI response."
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.copiedText = "Error: \(error.localizedDescription)"
            }
        }
    }
}