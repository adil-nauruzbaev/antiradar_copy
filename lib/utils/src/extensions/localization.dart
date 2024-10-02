import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextLocalization on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}

extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}

extension ThemeExtension on BuildContext {
  // CustomColors get customTheme => Theme.of(this).extension<CustomColors>()!;
  ThemeData get theme => Theme.of(this);
}
