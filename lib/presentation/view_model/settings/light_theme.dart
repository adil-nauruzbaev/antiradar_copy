import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

final lightTheme = ThemeData.light().copyWith(
    extensions: [
      const GradientExtension(
        gradient: LinearGradient(
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
      )
    ],
);
