// Servicio para traducción automática de textos
// Utiliza GoogleTranslator para traducir entre idiomas
import 'package:translator/translator.dart';

class TranslationService {
  // Idiomas de la app que Google Translate puede traducir desde español
  static String? googleCode(String lang) {
    switch (lang) {
      case 'en':
      case 'pt':
      case 'fr':
      case 'de':
        return lang;
      case 'zh':
        return 'zh-cn';
      default:
        return null;
    }
  }

  // Instancia de GoogleTranslator
  static final GoogleTranslator _translator = GoogleTranslator();

  // Caché para no repetir traducciones
  static final Map<String, Future<String>> _cache = {};

  // Traduce texto de un idioma a otro
  static Future<String> translateText(
      String text, String from, String to) async {
    if (text.trim().isEmpty) return text;
    return _cache.putIfAbsent('$from|$to|$text', () async {
      try {
        final translation =
            await _translator.translate(text, from: from, to: to);
        return translation.text;
      } catch (e) {
        return text; // Si falla, retorna el texto original
      }
    });
  }
}
