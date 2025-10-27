import 'package:flutter/material.dart';
import 'package:narino_travel_food/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;
  const LanguageSelector({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Normalizar el locale para que solo sea 'es' o 'en'
    Locale normalizedLocale;
    if (currentLocale.languageCode == 'es') {
      normalizedLocale = const Locale('es');
    } else if (currentLocale.languageCode == 'en') {
      normalizedLocale = const Locale('en');
    } else {
      normalizedLocale = const Locale('es'); // fallback
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        value: normalizedLocale,
        icon: const Icon(Icons.language, color: Colors.white),
        dropdownColor: Colors.green.shade700,
        items: [
          DropdownMenuItem(
            value: const Locale('es'),
            child: Text(AppLocalizations.of(context)?.spanish ?? 'Español'),
          ),
          DropdownMenuItem(
            value: const Locale('en'),
            child: Text(AppLocalizations.of(context)?.english ?? 'English'),
          ),
        ],
        onChanged: (locale) {
          if (locale != null) {
            onLocaleChanged(locale);
          }
        },
      ),
    );
  }
}
