import 'package:translator/translator.dart';

class TranslationService {
  static final GoogleTranslator _translator = GoogleTranslator();

  static Future<String> translateText(
      String text, String from, String to) async {
    if (text.trim().isEmpty) return text;
    try {
      final translation = await _translator.translate(text, from: from, to: to);
      return translation.text;
    } catch (e) {
      return text; // Si falla, retorna el texto original
    }
  }
}
