import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

final lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.lightBackgroundColor,
  textTheme: TextTheme(
    titleLarge: AppFonts.sfProRegular.copyWith(color: AppColors.lightTextColor, fontSize: 24),
    headlineMedium: AppFonts.interMedium
        .copyWith(color: AppColors.lightTextColor, fontSize: 18),
    headlineSmall:
        AppFonts.interMedium.copyWith(color: AppColors.grayText, fontSize: 14),
  ),
  colorScheme: const ColorScheme.light().copyWith(
      // appbar
      surface: AppColors.lightBackgroundColor,
      onSurface: AppColors.lightTextColor),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.lightMenuColor,
  ),
  extensions: [
    GradientExtension(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gradientColor1,
          AppColors.gradientColor2,
          AppColors.gradientColor3,
          AppColors.gradientColor4,
          AppColors.gradientColor5,
        ],
        stops: [0.06, 0.41, 0.64, 0.8, 1],
      ),
      radarGradient: null,
      viewGradient: RadialGradient(
        colors: [
          AppColors.lightViewColor.withOpacity(0.2),
          AppColors.lightViewColor.withOpacity(0.1),
          Colors.white.withOpacity(0.3)
        ],
        stops: const [0.1, 0.6, 1],
      ),
    ),
    AppColorsExtension(
      highlightedStrokeColor: AppColors.gradientColor5.withOpacity(0.12),
      strokeColor: AppColors.lightStrokeVersionCardColor,
      settingsBackground: AppColors.lightSettingsBackground,
      settingsTileColor: AppColors.lightSettingsTileColor,
      settingsStrokeColor: AppColors.lightSettingsStrokeColor,
      radarColors: RadarColors(linesColor: AppColors.lightLinesColor)
    )
  ],
);
