//
//  textrewriterApp.swift
//  textrewriter
//
//  Created by Jordy van Domselaar on 10/02/2025.
//

import SwiftUI

@main
struct textrewriterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        Settings {
            SettingsView()
        }
        MenuBarExtra("Text Rewriter", systemImage: "pencil") {
            SettingsLink()
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }

}
