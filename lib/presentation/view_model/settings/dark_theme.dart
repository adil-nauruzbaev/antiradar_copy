import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.darkBackgroundColor,
  textTheme: TextTheme(
    titleLarge: AppFonts.sfProRegular.copyWith(
        color: AppColors.darkTextColor, fontSize: 24),
    headlineMedium: AppFonts.interMedium.copyWith(
        color: AppColors.darkTextColor, fontSize: 18),
    headlineSmall: AppFonts.interMedium.copyWith(
        color: AppColors.grayText, fontSize: 14),
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    // appbar
      surface: AppColors.darkBackgroundColor,
      onSurface: AppColors.darkTextColor
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.darkMenuColor,
  ),
  extensions: [
    GradientExtension(
      gradient: darkGradient,
      radarGradient: darkGradient,
      viewGradient: RadialGradient(
        colors: [
          Colors.white.withOpacity(0.2),
          AppColors.darkViewColor.withOpacity(0.2),
          Colors.transparent
        ],
        stops: const [0, 0.9, 1],
      ),
    ),
    AppColorsExtension(
        highlightedStrokeColor: AppColors.gradientColor5.withOpacity(0.35),
        strokeColor: AppColors.darkStrokeVersionCardColor,
        settingsBackground: AppColors.darkSettingsBackground,
        settingsTileColor: AppColors.darkSettingsTileColor,
        settingsStrokeColor: AppColors.darkSettingsStrokeColor,
        radarColors: RadarColors(linesColor: AppColors.darkLinesColor)
    )
  ],
);

const darkGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    AppColors.darkColor,
    AppColors.gradientColor7,
  ],
  stops: [0.0367, 1],
);
