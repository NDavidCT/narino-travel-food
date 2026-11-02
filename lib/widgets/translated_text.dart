// Texto que se traduce automáticamente al inglés cuando la app está en ese idioma
import 'package:flutter/material.dart';
import 'package:narino_travel_food/services/content_translations_qu.dart';
import 'package:narino_travel_food/services/translation_service.dart';

class TranslatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  State<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  String? _translated;
  String? _requestKey;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(TranslatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) _update();
  }

  Future<void> _update() async {
    final lang = Localizations.localeOf(context).languageCode;
    final target = TranslationService.googleCode(lang);
    final key = '$lang|${widget.text}';
    if (_requestKey == key) return;
    _requestKey = key;
    if (lang == 'qu') {
      setState(() => _translated = kichwaTexts[widget.text]);
      return;
    }
    if (target == null || widget.text.trim().isEmpty) {
      if (_translated != null) setState(() => _translated = null);
      return;
    }
    final result =
        await TranslationService.translateText(widget.text, 'es', target);
    if (!mounted || _requestKey != key) return;
    setState(() => _translated = result);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _translated ?? widget.text,
      style: widget.style,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
