import 'package:antiradar/data/source/shared_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    switch (UserPref.language) {
      case 'ru':
        return const Locale('ru', 'RU');
      case 'pt':
        return const Locale('pt', 'BR');
      case 'es':
        return const Locale('es', 'ES');
      default:
        return const Locale('en', 'US');
    }
  }

  void setLocale(Locale locale) {
    UserPref.language = locale.languageCode;
    state = locale;
  }
}
