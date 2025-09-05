import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(LanguageTranslatorApp());
}

class LanguageTranslatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lingua Pro',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Colors.blue.shade700,
          secondary: Colors.teal.shade400,
          background: Colors.grey.shade50,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.black,
          onSurface: Colors.black,
        ),
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.blue.shade300,
          secondary: Colors.teal.shade300,
          background: Colors.grey.shade900,
          surface: Colors.grey.shade800,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.system,
      home: TranslatorHome(),
    );
  }
}

class TranslatorHome extends StatefulWidget {
  @override
  _TranslatorHomeState createState() => _TranslatorHomeState();
}

class _TranslatorHomeState extends State<TranslatorHome> {
  final translator = GoogleTranslator();
  final FlutterTts tts = FlutterTts();
  final TextEditingController _textController = TextEditingController();

  String _translatedText = '';
  String _fromLang = 'en';
  String _toLang = 'es';
  bool _isTranslating = false;
  bool _isSpeaking = false;

  final Map<String, String> allLanguages = {
    'Auto Detect': 'auto',
    'Afrikaans': 'af',
    'Albanian': 'sq',
    'Arabic': 'ar',
    'Armenian': 'hy',
    'Azerbaijani': 'az',
    'Basque': 'eu',
    'Bengali': 'bn',
    'Bosnian': 'bs',
    'Bulgarian': 'bg',
    'Catalan': 'ca',
    'Chinese (Simplified)': 'zh-cn',
    'Chinese (Traditional)': 'zh-tw',
    'Croatian': 'hr',
    'Czech': 'cs',
    'Danish': 'da',
    'Dutch': 'nl',
    'English': 'en',
    'Estonian': 'et',
    'Filipino': 'tl',
    'Finnish': 'fi',
    'French': 'fr',
    'Georgian': 'ka',
    'German': 'de',
    'Greek': 'el',
    'Gujarati': 'gu',
    'Hebrew': 'he',
    'Hindi': 'hi',
    'Hungarian': 'hu',
    'Icelandic': 'is',
    'Indonesian': 'id',
    'Italian': 'it',
    'Japanese': 'ja',
    'Kannada': 'kn',
    'Korean': 'ko',
    'Latvian': 'lv',
    'Lithuanian': 'lt',
    'Malay': 'ms',
    'Marathi': 'mr',
    'Norwegian': 'no',
    'Persian': 'fa',
    'Polish': 'pl',
    'Portuguese': 'pt',
    'Punjabi': 'pa',
    'Romanian': 'ro',
    'Russian': 'ru',
    'Serbian': 'sr',
    'Slovak': 'sk',
    'Slovenian': 'sl',
    'Spanish': 'es',
    'Swahili': 'sw',
    'Swedish': 'sv',
    'Tamil': 'ta',
    'Telugu': 'te',
    'Thai': 'th',
    'Turkish': 'tr',
    'Ukrainian': 'uk',
    'Urdu': 'ur',
    'Vietnamese': 'vi',
    'Welsh': 'cy',
  };

  @override
  void initState() {
    super.initState();
    _setupTts();
  }

  void _setupTts() async {
    tts.setStartHandler(() {
      setState(() {
        _isSpeaking = true;
      });
    });

    tts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });

    tts.setErrorHandler((message) {
      setState(() {
        _isSpeaking = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('TTS Error: $message')),
      );
    });
  }

  void _translateText() async {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _isTranslating = true;
    });

    try {
      // Fix for null safety - handle auto detection properly
      if (_fromLang == 'auto') {
        // When auto-detecting, don't pass the from parameter
        final translation = await translator.translate(
          _textController.text.trim(),
          to: _toLang,
        );
        setState(() {
          _translatedText = translation.text;
          _isTranslating = false;
        });
      } else {
        // When a specific language is selected, pass the from parameter
        final translation = await translator.translate(
          _textController.text.trim(),
          from: _fromLang,
          to: _toLang,
        );
        setState(() {
          _translatedText = translation.text;
          _isTranslating = false;
        });
      }
    } catch (e) {
      setState(() {
        _isTranslating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Translation failed: $e'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _copyText() {
    if (_translatedText.isEmpty) return;
    FlutterClipboard.copy(_translatedText).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied to clipboard'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    });
  }

  void _speakText() async {
    if (_translatedText.isEmpty) return;

    try {
      // Set language for TTS
      String ttsLanguage = _toLang;
      if (_toLang == 'zh-cn' || _toLang == 'zh-tw') {
        ttsLanguage = 'zh-CN';
      } else if (_toLang == 'he') {
        ttsLanguage = 'iw'; // Hebrew code fix
      }

      await tts.setLanguage(ttsLanguage);
      await tts.setPitch(1.0);
      await tts.setSpeechRate(0.5);
      await tts.speak(_translatedText);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Speech synthesis not available for this language'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _swapLanguages() {
    setState(() {
      String temp = _fromLang;
      _fromLang = _toLang;
      _toLang = temp;

      // If we had a translation, translate the current translated text back
      if (_translatedText.isNotEmpty) {
        String tempText = _textController.text;
        _textController.text = _translatedText;
        _translatedText = tempText;
      }
    });
  }

  Widget _buildLanguagePicker({
    required String label,
    required String selectedValue,
    required Function(String?) onChanged,
    bool isFrom = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownSearch<String>(
            items: isFrom ?
            ['Auto Detect', ...allLanguages.keys.where((key) => key != 'Auto Detect').toList()] :
            allLanguages.keys.toList(),
            selectedItem: allLanguages.entries
                .firstWhere((entry) => entry.value == selectedValue)
                .key,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                hintText: label,
              ),
            ),
            popupProps: PopupProps.modalBottomSheet(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Search language...",
                  prefixIcon: Icon(Iconsax.search_normal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              title: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select $label Language',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item),
                trailing: isSelected ? Icon(Iconsax.tick_circle, color: Theme.of(context).colorScheme.primary) : null,
              ),
            ),
            onChanged: (String? selectedLanguage) {
              if (selectedLanguage != null) {
                onChanged(allLanguages[selectedLanguage]);
                if (_translatedText.isNotEmpty) {
                  _translateText();
                }
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Tanslator App',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onBackground,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Language selection row
              Row(
                children: [
                  Expanded(
                    child: _buildLanguagePicker(
                      label: 'From',
                      selectedValue: _fromLang,
                      onChanged: (val) => setState(() => _fromLang = val!),
                      isFrom: true,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: IconButton(
                      onPressed: _swapLanguages,
                      icon: Icon(Iconsax.arrow_swap_horizontal),
                      style: IconButton.styleFrom(
                        backgroundColor: colorScheme.primary.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildLanguagePicker(
                      label: 'To',
                      selectedValue: _toLang,
                      onChanged: (val) => setState(() => _toLang = val!),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Input text field
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter text to translate...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                    suffixIcon: _textController.text.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        _textController.clear();
                        setState(() {
                          _translatedText = '';
                        });
                      },
                      icon: Icon(Iconsax.close_circle),
                    )
                        : null,
                  ),
                  onChanged: (value) => setState(() {}),
                ),
              ),

              SizedBox(height: 20),

              // Translate button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _textController.text.isEmpty ? null : _translateText,
                  child: _isTranslating
                      ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                      : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.translate),
                      SizedBox(width: 8),
                      Text('Translate'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Translation result
              if (_translatedText.isNotEmpty) ...[
                Text(
                  'Translation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SelectableText(
                    _translatedText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 16),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: _copyText,
                      icon: Icon(Iconsax.copy, size: 20),
                      label: Text('Copy'),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: _isSpeaking ? null : _speakText,
                      icon: _isSpeaking
                          ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(colorScheme.onPrimary),
                        ),
                      )
                          : Icon(Iconsax.voice_cricle, size: 20),
                      label: Text(_isSpeaking ? 'Speaking...' : 'Speak'),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.secondary,
                        foregroundColor: colorScheme.onSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else if (_isTranslating) ...[
                SizedBox(height: 40),
                CircularProgressIndicator(
                  color: colorScheme.primary,
                ),
                SizedBox(height: 16),
                Text(
                  'Translating...',
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],

              Spacer(),

              // Footer note
              Text(
                'Powered by Google Translate',
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}