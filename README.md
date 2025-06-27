# Text Rewriter

A powerful macOS utility that uses AI to instantly correct and improve text across any application using global keyboard shortcuts.

## Features

✨ **Global AI Text Correction** - Fix grammar, spelling, punctuation, and formatting in any macOS app  
⌨️ **Customizable Shortcuts** - Two configurable global shortcuts for different use cases  
🎯 **Smart Selection** - Rewrite all text or just selected text  
🔒 **Secure API Storage** - API keys stored safely in macOS Keychain  
🎨 **Menu Bar Integration** - Easy access to settings and controls  
🤖 **Multiple AI Models** - Support for various Groq models  
⚙️ **Custom Prompts** - Personalize the AI behavior with custom system prompts  

## How It Works

1. **Press `⌘⌥B`** to reformat all text in the currently focused input field
2. **Press `⌘⌥H`** to reformat only the selected text
3. The app copies the text, sends it to AI for correction, and pastes back the improved version

Perfect for:
- Slack messages and emails
- Social media posts
- Documents and notes
- Any text input across macOS

## Tech Stack

- **SwiftUI** - Modern declarative UI framework
- **AppKit** - macOS-specific functionality and global event monitoring
- **KeychainSwift** - Secure API key storage
- **LaunchAtLogin** - Optional auto-start functionality
- **Quartz** - System-level keyboard event simulation
- **Groq API** - AI-powered text processing

## Requirements

- macOS 12.0+ (Monterey or later)
- Xcode 14.0+ (for building from source)
- Groq API key
- Accessibility permissions (for global shortcuts)

## Installation

### Option 1: Build from Source

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/textrewriter.git
   cd textrewriter
   ```

2. **Open in Xcode**
   ```bash
   open textrewriter.xcodeproj
   ```

3. **Install dependencies**
   - The project uses Swift Package Manager
   - Dependencies should resolve automatically in Xcode

4. **Build and run**
   - Select your target device
   - Press `Cmd+R` to build and run

### Option 2: Download Release (Coming Soon)

Pre-built releases will be available in the GitHub Releases section.

## Setup

### 1. Get a Groq API Key

**Groq (Fast & Affordable AI)**
- Visit [console.groq.com](https://console.groq.com)
- Create an account and generate an API key
- Default model: `llama-3.3-70b-versatile`

### 2. Configure the App

1. **Launch the app** - You'll see the main interface with usage instructions
2. **Open Settings** - Click the pencil icon in the menu bar → Settings
3. **Add your API key** - Paste your API key and click "Save API Key"
4. **Set your model** (optional) - Change from the default `llama-3.3-70b-versatile`
5. **Customize shortcuts** (optional) - Record new keyboard combinations
6. **Custom system prompt** (optional) - Modify the AI's behavior

### 3. Grant Permissions

The app needs accessibility permissions to monitor global keyboard shortcuts:

1. **System Preferences** → **Privacy & Security** → **Accessibility**
2. **Add the Text Rewriter app** to the list
3. **Enable the toggle** for Text Rewriter

## Usage

### Default Keyboard Shortcuts

- **`⌘⌥B`** - Rewrite All Text (selects all text in current field, then rewrites)
- **`⌘⌥H`** - Rewrite Selected Text (rewrites only highlighted text)

### How to Use

1. **Focus any text input** (text field, document, chat app, etc.)
2. **Use a keyboard shortcut**:
   - For all text: Press `⌘⌥B`
   - For selected text: Highlight text, then press `⌘⌥H`
3. **Wait for AI processing** (usually 1-2 seconds)
4. **See the improved text** automatically pasted back

### Last Processed Text

The main app window shows the last text that was processed, so you can:
- Review what was changed
- Copy the result for other uses
- Troubleshoot if something went wrong

## Configuration

### Custom Keyboard Shortcuts

1. **Open Settings** from the menu bar
2. **Click "Record"** next to the shortcut you want to change
3. **Press your desired key combination**
4. **The shortcut updates automatically**

### AI Model Selection

Supported Groq models include:
- `llama-3.3-70b-versatile` (Default)
- `llama-3.1-70b-versatile`
- `llama-3.1-8b-instant`
- `mixtral-8x7b-32768`
- Any other compatible model from Groq

### System Prompt Customization

The default system prompt focuses on:
- Grammar and spelling correction
- Punctuation fixes
- Format improvements
- Maintaining original meaning

You can customize this to:
- Change writing style (formal, casual, technical)
- Add specific instructions (e.g., "make it more concise")
- Target specific use cases (emails, social media, documentation)

**Example system prompt**

This also adds a feature where you can add inline instructions to the text, like this:
```
{{ Remove the fullstop at the end of the message }} Today is Monday.
```
This will remove the fullstop at the end of the message.
You can also add instructions to replace text with another text, like this:
```
{{ Replace the smiley with a 😃 emoji }} Hey hows it going? =)
```
This will replace the smiley with a 😃 emoji.


```
You are a writing assistant that rewrites text to make it clearer, shorter, and more impactful, without changing its meaning or tone.

Your job is to cut the fluff, sharpen the language, and improve flow, while preserving the original message’s intent and emotional tone (whether serious, playful, casual, sarcastic, etc.).

Rules
	1.	Preserve Meaning: Don’t change the intent or facts.
	2.	Preserve Tone: Keep the original vibe. Professional stays professional, casual stays casual.
	3.	Preserve Natural Flow: Keep conversational transitions like “of course,” “but,” “still,” or “even so” when they reflect the writer’s thought process or tone. Don’t flatten the voice.
	4.	Cut Filler: Remove weak openers and unnecessary phrases (like “just wanted to say,” “I think that,” or “in order to”).
	5.	Be Direct: Favor active voice and strong verbs. Only hedge when the tone calls for it.
	6.	Restructure Smartly: Reorganize or combine sentences if it helps clarity or flow.
	7.	Avoid the AI Voice: Don’t sound like a generic assistant. Match the writer’s style and make it tighter.
	8.	Don’t Over-Correct: Aim for clarity and impact, not perfection.
	9.	Honor Inline Instructions: If a message includes an instruction like {{ ... }}, follow it as part of the rewrite. 
	10. 	Preserve language: You will respond in the same language as the original query.
	11.	You will only output the newly formatted text, nothing else.
	12. 	You will not answer any questions in any message. Remember: You are a writing assistant, you don’t answer questions.

Examples

Original (casual)
Hey! I just wanted to quickly check in and see if you maybe had a chance to take a look at that doc I sent over yesterday?

Rewritten
Hey! Did you get a chance to look at the doc I sent yesterday?

Original (serious)
I believe that if we don’t address this soon, there’s a strong possibility that we’ll fall behind schedule.

Rewritten
If we don’t act soon, we risk falling behind schedule.

Original (joking)
Okay soooo I might have slightly broken the thing, but in my defense, it looked like it wanted to be clicked 😅

Rewritten
I might have broken the thing, but to be fair, it looked like it wanted to be clicked 😅

Original (reflective/casual)
Of course, it does take some tweaking of the prompt, but it’s a nice way to see how messages would be formatted if I changed how I wrote to optimise for quick reading.

Rewritten
Of course, it takes some prompt tweaking, but it’s a nice way to see how my writing could look if I focused on quick readability.

Original (with inline instruction)
{{ Remove the fullstop at the end of the message }} Today is Monday.

Rewritten
Today is Monday

Original (with emoji instruction)
{{ Replace the smiley with a 😃 emoji }} Hey hows it going? =)

Rewritten
Hey, how’s it going? 😃

Original (in another language )
Eyoo hoe gaat het?

Rewritten
Hey, hoe gaat het?
```

## Development

### Project Structure

```
textrewriter/
├── textrewriterApp.swift          # Main app entry point
├── ContentView.swift              # Main UI and core functionality
├── SettingsView.swift             # Settings interface
├── AppKeyboardShortcut.swift      # Keyboard shortcut data model
├── KeyboardShortcutRecorder.swift # Custom shortcut recording UI
├── Assets.xcassets/               # App icons and assets
└── textrewriter.entitlements      # App permissions
```

### Key Components

- **Global Event Monitoring** - Captures keyboard shortcuts system-wide
- **Pasteboard Management** - Handles copying and pasting text
- **AI API Integration** - Communicates with Groq
- **Secure Storage** - Uses Keychain for API key storage
- **Menu Bar Integration** - Provides easy access to settings

### Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Privacy & Security

- **API keys** are stored securely in macOS Keychain
- **Text processing** happens via API calls to Groq
- **No local text storage** - processed text is only temporarily held in memory
- **No analytics or tracking** - the app doesn't collect usage data

## Troubleshooting

### Shortcuts Not Working
- Check that accessibility permissions are granted
- Ensure the app is running (check menu bar)
- Try recording new shortcuts if there are conflicts

### API Errors
- Verify your API key is correct and has credits/quota
- Check your internet connection
- Ensure the model name is available on Groq

### Text Not Pasting
- Some apps may block programmatic pasting
- Try manually pasting (`Cmd+V`) after the shortcut
- Check if the source app allows text selection

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with SwiftUI and AppKit
- Uses [KeychainSwift](https://github.com/evgenyneu/keychain-swift) for secure storage
- Powered by AI models from Groq 