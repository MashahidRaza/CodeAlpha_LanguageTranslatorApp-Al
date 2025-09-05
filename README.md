# CodeAlpha_LanguageTranslatorApp-Al
![Uploading Screenshot 2025-09-05 at 9.50.00 AM.png…]()


Google - Language Translator App

Translator is a feature-rich, multilingual translation application built with Flutter. It offers seamless text translation between numerous languages with additional features like text-to-speech and copy functionality.

Features

Multi-language Translation: Support for 60+ languages including Arabic, Chinese, Japanese, and many European languages
Auto-Detect Language: Automatically detects the source language for convenience
Text-to-Speech: Listen to your translations with integrated TTS functionality
Copy to Clipboard: Easily copy translated text with one click
Language Swap: Quickly swap between source and target languages
Modern UI: Clean, intuitive interface with dark/light theme support
Real-time Translation: Fast translation using Google Translate API
Supported Languages

The app supports translation between these languages: Afrikaans, Albanian, Arabic, Armenian, Azerbaijani, Basque, Bengali, Bosnian, Bulgarian, Catalan, Chinese (Simplified), Chinese (Traditional), Croatian, Czech, Danish, Dutch, English, Estonian, Filipino, Finnish, French, Georgian, German, Greek, Gujarati, Hebrew, Hindi, Hungarian, Icelandic, Indonesian, Italian, Japanese, Kannada, Korean, Latvian, Lithuanian, Malay, Marathi, Norwegian, Persian, Polish, Portuguese, Punjabi, Romanian, Russian, Serbian, Slovak, Slovenian, Spanish, Swahili, Swedish, Tamil, Telugu, Thai, Turkish, Ukrainian, Urdu, Vietnamese, Welsh.

How It Works

Input Text: Type or paste the text you want to translate in the input field
Select Languages:

Choose source language (or select "Auto Detect" for automatic detection)
Choose target language from the dropdown
Translate: Click the translate button to convert your text
Additional Actions:

Use the speaker icon to hear the translation
Use the copy icon to copy the translated text to clipboard
Use the swap icon to quickly switch between source and target languages
Technical Implementation

Architecture

The app follows a standard Flutter architecture with:

Stateful Widgets for managing translation state
Google Translator Package for translation services
Flutter TTS for text-to-speech functionality
Clipboard for copy operations
Dropdown Search for language selection
