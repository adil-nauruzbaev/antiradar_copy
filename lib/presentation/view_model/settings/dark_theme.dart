import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

final darkTheme = ThemeData.dark().copyWith(
    extensions: [
      const GradientExtension(gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gradientColor6,
          AppColors.gradientColor7,
        ],
        stops: [0.0367, 1],
      ),)
    ]
);