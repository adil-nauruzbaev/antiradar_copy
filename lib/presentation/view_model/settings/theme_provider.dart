import 'package:antiradar/presentation/view_model/settings/dark_theme.dart';
import 'package:antiradar/presentation/view_model/settings/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

enum AppTheme {
  light,
  dark,
}

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  AppTheme build() => AppTheme.light;

  void setTheme(AppTheme theme) => state = theme;
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


