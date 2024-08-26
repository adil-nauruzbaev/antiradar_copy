import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static List<String> languages(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [
      loc.english,
      loc.spanish,
      loc.portuguese,
      loc.russian];
  }

  static List<Locale> locales = const [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('pt', 'BR'),
    Locale('ru', 'RU'),
  ];
}
