// Ensure that OpenAIKeyInputView.swift is added to your build target so that OpenAIKeyInputView is in scope
import SwiftUI
import KeychainSwift

struct SettingsView: View {
    @State private var openAIKey: String = ""
    @State private var statusMessage: String = ""
    @AppStorage("systemPrompt") private var systemPrompt: String = ""
    @AppStorage("modelName") private var modelName: String = "llama-3.3-70b-versatile"
    
    // Keyboard shortcuts
    @AppStorage("keyboardShortcutAll") private var shortcutAllData: Data = try! JSONEncoder().encode(AppKeyboardShortcut.defaultAll)
    @AppStorage("keyboardShortcutHighlighted") private var shortcutHighlightedData: Data = try! JSONEncoder().encode(AppKeyboardShortcut.defaultHighlighted)
    @State private var currentShortcutAll: AppKeyboardShortcut = .defaultAll
    @State private var currentShortcutHighlighted: AppKeyboardShortcut = .defaultHighlighted
    
    private let keychain = KeychainSwift()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("OpenAI API Key")) {
                    SecureField("Enter your API Key", text: $openAIKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Section {
                    Button("Save API Key") {
                        if openAIKey.isEmpty {
                            statusMessage = "Enter a valid API key."
                        } else {
                            keychain.set(openAIKey, forKey: "textrewriter_openai_api_key")
                            statusMessage = "Key saved successfully!"
                        }
                    }
                }
                if !statusMessage.isEmpty {
                    Text(statusMessage)
                        .foregroundColor(.green)
                }
                
                Section(header: Text("Model")) {
                    TextField("Model Name", text: $modelName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Enter the model name to use for text rewriting (e.g. llama-3.3-70b-versatile, gpt-4, gpt-3.5-turbo)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Keyboard Shortcuts")) {
                    KeyboardShortcutRecorder(shortcut: $currentShortcutAll, defaultShortcut: .defaultAll)
                        .onChange(of: currentShortcutAll) { newValue in
                            do {
                                shortcutAllData = try JSONEncoder().encode(newValue)
                            } catch {
                                print("Failed to save keyboard shortcut: \(error)")
                            }
                        }
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    KeyboardShortcutRecorder(shortcut: $currentShortcutHighlighted, defaultShortcut: .defaultHighlighted)
                        .onChange(of: currentShortcutHighlighted) { newValue in
                            do {
                                shortcutHighlightedData = try JSONEncoder().encode(newValue)
                            } catch {
                                print("Failed to save keyboard shortcut: \(error)")
                            }
                        }
                }
                
                Section(header: Text("System Prompt")) {
                    TextEditor(text: $systemPrompt)
                        .frame(height: 150)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }
            }
            .navigationTitle("Settings")
        }
        .onAppear {
            if let savedKey = keychain.get("textrewriter_openai_api_key") {
                openAIKey = savedKey
            }
            
            do {
                currentShortcutAll = try JSONDecoder().decode(AppKeyboardShortcut.self, from: shortcutAllData)
                currentShortcutHighlighted = try JSONDecoder().decode(AppKeyboardShortcut.self, from: shortcutHighlightedData)
            } catch {
                print("Failed to load keyboard shortcuts: \(error)")
                currentShortcutAll = .defaultAll
                currentShortcutHighlighted = .defaultHighlighted
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
} 