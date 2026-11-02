// Flutter no incluye textos del sistema (Material/Cupertino) en Kichwa.
// Estos delegados los sirven en español cuando el idioma es 'qu'.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class _FallbackDelegate<T> extends LocalizationsDelegate<T> {
  final LocalizationsDelegate<T> base;
  const _FallbackDelegate(this.base);

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'qu' || base.isSupported(locale);

  @override
  Future<T> load(Locale locale) => base.load(
      locale.languageCode == 'qu' ? const Locale('es') : locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<T> old) => false;
}

const List<LocalizationsDelegate<dynamic>> kichwaFallbackDelegates = [
  _FallbackDelegate<MaterialLocalizations>(GlobalMaterialLocalizations.delegate),
  _FallbackDelegate<WidgetsLocalizations>(GlobalWidgetsLocalizations.delegate),
  _FallbackDelegate<CupertinoLocalizations>(
      GlobalCupertinoLocalizations.delegate),
];
