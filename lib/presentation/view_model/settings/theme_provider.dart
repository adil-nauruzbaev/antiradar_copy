import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      return ThemeData.dark();
    case AppTheme.light:
    default:
      return ThemeData.light();
  }
}
