# Text Rewriter

A macOS menu bar application that helps you improve your writing by automatically fixing grammar, spelling, punctuation, and formatting using OpenAI's GPT-4. Perfect for quick text improvements without interrupting your workflow.

## Features

- 🎯 Lives in your menu bar for quick access
- ⌨️ Global keyboard shortcuts for:
  - Rewriting all text in the current input field (default: ⌘⌥B)
  - Rewriting only selected text (default: ⌘⌥H)
- 🤖 Uses OpenAI's GPT-4 for intelligent text improvements
- 🔒 Secure API key storage using Keychain
- ⚡️ Launch at login support
- ⚙️ Customizable system prompt for tailored text improvements
- 🎨 Ugly af but you're not going to be looking at the UI anyway

## Installation

1. Download the latest release from the [releases page](https://github.com/jordyvandomselaar/textrewriter/releases)
2. Move the app to your Applications folder
3. Launch the app
4. Configure your OpenAI API key in the settings

## Usage

1. Click the pencil icon in the menu bar to access the app
2. Open settings to configure your OpenAI API key and customize keyboard shortcuts
3. Use the keyboard shortcuts anywhere in macOS:
   - Press ⌘⌥B to rewrite all text in the current input field
   - Press ⌘⌥H to rewrite only the selected text
4. The app will automatically copy your text, improve it using GPT-4, and paste it back

## Configuration

### OpenAI API Key
1. Get your API key from [OpenAI's website](https://platform.openai.com/api-keys)
2. Open the app settings
3. Enter your API key in the designated field

### Keyboard Shortcuts
1. Open the app settings
2. Click "Record" next to the shortcut you want to change
3. Press your desired key combination
4. Click "Reset" to restore the default shortcut

### System Prompt
Customize how the AI improves your text by modifying the system prompt in settings. The default prompt instructs the AI to fix grammar, spelling, punctuation, and formatting while preserving the original meaning.

## Requirements

- macOS 15.0 or later
- OpenAI API key
- Internet connection

## License

MIT License

Copyright (c) 2025 Jordy van Domselaar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. 

## FAQ

### This is the ugliest code I've ever seen.

Yes, it is. I don't care. I'm going to invest time in learning Swift and SwiftUI, but I've let Cursor Composer generate this entire thing, including this README.

