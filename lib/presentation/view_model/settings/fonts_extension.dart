import 'package:flutter/material.dart';

class AppFontsExtension extends ThemeExtension<AppFontsExtension>{
  final TextStyle? staticChamberTextStyle;
  final TextStyle? alertTextStyle;
  final TextStyle? alertTextStyle2;
  final TextStyle? alertTextStyle3;

  AppFontsExtension({
    required this.staticChamberTextStyle,
    required this.alertTextStyle,
    required this.alertTextStyle2,
    required this.alertTextStyle3,
    });

  @override
  ThemeExtension<AppFontsExtension> copyWith({
    TextStyle? staticChamberTextStyle,
    TextStyle? alertTextStyle,
    TextStyle? alertTextStyle2,
    TextStyle? alertTextStyle3,
  }) {
    return AppFontsExtension(
      staticChamberTextStyle: staticChamberTextStyle ?? this.staticChamberTextStyle,
      alertTextStyle: alertTextStyle ?? this.alertTextStyle,
      alertTextStyle2: alertTextStyle2 ?? this.alertTextStyle2,
      alertTextStyle3: alertTextStyle3 ?? this.alertTextStyle3,
    );
  }

  @override
  ThemeExtension<AppFontsExtension> lerp(
      covariant ThemeExtension<AppFontsExtension>? other,
      double t,
      ) {
    if (other is! AppFontsExtension) {
      return this;
    }

    return AppFontsExtension(
      staticChamberTextStyle: TextStyle.lerp(staticChamberTextStyle, other.staticChamberTextStyle, t),
      alertTextStyle: TextStyle.lerp(alertTextStyle, other.alertTextStyle, t),
      alertTextStyle2: TextStyle.lerp(alertTextStyle2, other.alertTextStyle2, t),
      alertTextStyle3: TextStyle.lerp(alertTextStyle3, other.alertTextStyle3, t),
    );
  }

}

extension AppColorsExt on ThemeData {
  AppFontsExtension get appFonts => extension<AppFontsExtension>()!;
}