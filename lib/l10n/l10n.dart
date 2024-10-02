import 'package:antiradar/utils/src/extensions/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../presentation/router/app_router.dart';

class L10n {
  static List<String> languages(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [loc.english, loc.spanish, loc.portuguese, loc.russian];
  }

  static List<Locale> locales = const [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('pt', 'BR'),
    Locale('ru', 'RU'),
  ];
}

enum LanguageEnum { english, spanish, portuguese, russian ;
  String loc() {
    final loc = navigatorKey.currentState!.context.localization;
    return switch (this) {
      english => loc.english,
      spanish => loc.spanish,
      portuguese => loc.portuguese,
      russian => loc.russian,
    };
  }

  Locale locale() {
    return switch (this) {
      english => const Locale('en', 'US'),
      spanish => const Locale('es', 'ES'),
      portuguese => const Locale('pt', 'BR'),
      russian => const Locale('ru', 'RU')
    };
  }

  String path() {
    return switch (this) {
      english => 'assets/icons/country_flags/lang_flags/usa.svg',
      spanish => 'assets/icons/country_flags/lang_flags/spain.svg',
      portuguese => 'assets/icons/country_flags/lang_flags/portugal.svg',
      russian => 'assets/icons/country_flags/lang_flags/russia.svg',
    };
  }
}




