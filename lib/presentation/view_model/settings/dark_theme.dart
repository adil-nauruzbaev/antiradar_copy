import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.darkBackgroundColor,
  textTheme: TextTheme(
    headlineMedium: AppFonts.interMedium.copyWith(color: AppColors.darkTextColor, fontSize: 18),
    headlineSmall: AppFonts.interMedium.copyWith(color: AppColors.grayText, fontSize: 14),
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
    const GradientExtension(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gradientColor6,
          AppColors.gradientColor7,
        ],
        stops: [0.0367, 1],
      ),
    )
  ],
);

