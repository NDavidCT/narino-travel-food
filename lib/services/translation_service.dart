// Servicio para traducción automática de textos
// Utiliza GoogleTranslator para traducir entre idiomas
import 'package:translator/translator.dart';

class TranslationService {
  // Instancia de GoogleTranslator
  static final GoogleTranslator _translator = GoogleTranslator();

  // Traduce texto de un idioma a otro
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
