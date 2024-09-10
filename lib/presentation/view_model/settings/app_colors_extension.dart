import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.strokeColor,
    required this.highlightedStrokeColor,
    required this.settingsBackground,
    required this.settingsTileColor,
    required this.settingsStrokeColor,
    required this.radarColors
  });

  final Color? strokeColor;
  final Color? highlightedStrokeColor;
  final Color? settingsBackground;
  final Color? settingsTileColor;
  final Color? settingsStrokeColor;
  final RadarColors? radarColors;

  @override
  AppColorsExtension copyWith({
    Color? strokeColor,
    Color? highlightedStrokeColor,
    Color? settingsBackground,
    Color? settingsTileColor,
    Color? settingsStrokeColor,
    RadarColors? radarColors
  }) {
    return AppColorsExtension(
      strokeColor: strokeColor ?? this.strokeColor,
      highlightedStrokeColor:
      highlightedStrokeColor ?? this.highlightedStrokeColor,
      settingsBackground: settingsBackground ?? this.settingsBackground,
      settingsTileColor: settingsTileColor ?? this.settingsTileColor,
      settingsStrokeColor: settingsStrokeColor ?? this.settingsStrokeColor,
      radarColors: radarColors ?? this.radarColors
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      strokeColor: Color.lerp(strokeColor, other.strokeColor, t),
      highlightedStrokeColor:
      Color.lerp(highlightedStrokeColor, other.highlightedStrokeColor, t),
      settingsBackground:
      Color.lerp(settingsBackground, other.settingsBackground, t),
      settingsTileColor:
      Color.lerp(settingsTileColor, other.settingsTileColor, t),
      settingsStrokeColor:
      Color.lerp(settingsStrokeColor, other.settingsStrokeColor, t),
      radarColors: RadarColors(
          linesColor: Color.lerp(radarColors!.linesColor, other.radarColors!.linesColor, t),
          //viewColor: Color.lerp(radarColors!.viewColor, other.radarColors!.viewColor, t)
      )
    );
  }
}

extension AppColorsExt on ThemeData {
  AppColorsExtension get appColors => extension<AppColorsExtension>()!;
}

class RadarColors{
  RadarColors({
    required this.linesColor,
    //required this.viewColor
});

  final Color? linesColor;
  //final Color? viewColor;
}
