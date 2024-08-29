import 'package:antiradar/presentation/view_model/settings/dark_theme.dart';
import 'package:antiradar/presentation/view_model/settings/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/source/shared_preferences/user_preferences.dart';

part 'theme_provider.g.dart';

enum AppTheme {
  light,
  dark,
}

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  AppTheme build() => UserPref.isDark ? AppTheme.dark : AppTheme.light;

  void setTheme(AppTheme theme){
    UserPref.isDark = theme == AppTheme.dark;
    state = theme;}
}

ThemeData themeData(AppTheme theme) {
  switch (theme) {
    case AppTheme.dark:
      return darkTheme;
    case AppTheme.light:
    default:
      return lightTheme;
  }
}


