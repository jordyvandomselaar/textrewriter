import Foundation
import AppKit

struct AppKeyboardShortcut: Codable, Equatable, CustomStringConvertible {
    var name: String
    var keyCode: UInt16
    var modifierFlags: NSEvent.ModifierFlags
    
    enum CodingKeys: String, CodingKey {
        case name
        case keyCode
        case modifierFlagsRaw = "modifierFlags"
    }
    
    init(name: String, keyCode: UInt16, modifierFlags: NSEvent.ModifierFlags) {
        self.name = name
        self.keyCode = keyCode
        self.modifierFlags = modifierFlags
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        keyCode = try container.decode(UInt16.self, forKey: .keyCode)
        let rawValue = try container.decode(UInt.self, forKey: .modifierFlagsRaw)
        modifierFlags = NSEvent.ModifierFlags(rawValue: rawValue)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(keyCode, forKey: .keyCode)
        try container.encode(modifierFlags.rawValue, forKey: .modifierFlagsRaw)
    }
    
    static var defaultAll: AppKeyboardShortcut {
        AppKeyboardShortcut(
            name: "Rewrite All Text",
            keyCode: 11, // B key
            modifierFlags: [.command, .option]
        )
    }
    
    static var defaultHighlighted: AppKeyboardShortcut {
        AppKeyboardShortcut(
            name: "Rewrite Selected Text",
            keyCode: 4, // H key
            modifierFlags: [.command, .option]
        )
    }
    
    var description: String {
        var result = ""
        
        if modifierFlags.contains(.command) {
            result += "⌘"
        }
        if modifierFlags.contains(.option) {
            result += "⌥"
        }
        if modifierFlags.contains(.shift) {
            result += "⇧"
        }
        if modifierFlags.contains(.control) {
            result += "⌃"
        }
        
        if let characters = AppKeyboardShortcut.keyCodeToString[keyCode] {
            result += characters.uppercased()
        }
        
        return result
    }
    
    // Common key codes mapping
    static let keyCodeToString: [UInt16: String] = [
        0: "a", 1: "s", 2: "d", 3: "f", 4: "h", 5: "g", 6: "z", 7: "x",
        8: "c", 9: "v", 11: "b", 12: "q", 13: "w", 14: "e", 15: "r",
        16: "y", 17: "t", 32: "u", 31: "o", 35: "p", 37: "l", 38: "j",
        39: "'", 40: "k", 41: ";", 46: "m", 45: "n", 48: "tab", 49: "space"
    ]
} 