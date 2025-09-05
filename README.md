# CodeAlpha_LanguageTranslatorApp-Al
<img width="1224" height="738" alt="Screenshot 2025-09-05 at 9 50 00 AM" src="https://github.com/user-attachments/assets/c075e494-2628-46de-a0dc-fa27573b12ca" />

https://github.com/user-attachments/assets/96d9fb38-f18b-45d1-85dd-2af6f9ddc7c1

# 🌍 Google - Language Translator App

**Translator** is a feature-rich, multilingual translation application built with Flutter. It offers seamless text translation between numerous languages with additional features like **text-to-speech** and **copy functionality**.

---

## 🚀 Features

- ✅ **Multi-language Translation**: Support for 60+ languages including Arabic, Chinese, Japanese, and many European languages  
- 🌐 **Auto-Detect Language**: Automatically detects the source language  
- 🔊 **Text-to-Speech**: Listen to your translations with integrated TTS functionality  
- 📋 **Copy to Clipboard**: Easily copy translated text with one click  
- 🔁 **Language Swap**: Quickly swap between source and target languages  
- 🎨 **Modern UI**: Clean, intuitive interface with dark/light theme support  
- ⚡ **Real-time Translation**: Fast translation using Google Translate API  

---

## 🌐 Supported Languages

The app supports translation between these languages:

> Afrikaans, Albanian, Arabic, Armenian, Azerbaijani, Basque, Bengali, Bosnian, Bulgarian, Catalan, Chinese (Simplified), Chinese (Traditional), Croatian, Czech, Danish, Dutch, English, Estonian, Filipino, Finnish, French, Georgian, German, Greek, Gujarati, Hebrew, Hindi, Hungarian, Icelandic, Indonesian, Italian, Japanese, Kannada, Korean, Latvian, Lithuanian, Malay, Marathi, Norwegian, Persian, Polish, Portuguese, Punjabi, Romanian, Russian, Serbian, Slovak, Slovenian, Spanish, Swahili, Swedish, Tamil, Telugu, Thai, Turkish, Ukrainian, Urdu, Vietnamese, Welsh.

---

## ⚙️ How It Works

### 📝 Input Text
Type or paste the text you want to translate in the input field.

### 🌍 Select Languages

- Choose **source language** (or select `"Auto Detect"` for automatic detection)  
- Choose **target language** from the searchable dropdown  

### 🔄 Translate

- Click the **Translate** button to convert your text

### 🎧 Additional Actions

- Use the 🔊 **Speaker icon** to hear the translation  
- Use the 📋 **Copy icon** to copy the translated text  
- Use the 🔁 **Swap icon** to switch between source and target languages  

---

## 🛠️ Technical Implementation

### 🧱 Architecture

The app follows a standard Flutter architecture with:

- `StatefulWidget` for managing translation and UI state  
- [`google_translator`](https://pub.dev/packages/translator) for language translation  
- [`flutter_tts`](https://pub.dev/packages/flutter_tts) for text-to-speech  
- [`clipboard`](https://pub.dev/packages/clipboard) for copy operations  
- [`dropdown_search`](https://pub.dev/packages/dropdown_search) for searchable dropdowns  

---

## 📦 Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  translator: ^0.1.7
  clipboard: ^0.1.3
  flutter_tts: ^3.6.3
  dropdown_search: ^5.0.6
