import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

class AppFonts{
  static TextStyle searchStyle = TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 17,
      color: AppColors.lclSecondary,
      fontWeight: FontWeight.normal
  );

  static const TextStyle textButtonStyle = TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 14,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w600
  );

  static const TextStyle headlineStyle =  TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 28,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w600 );

  static const TextStyle h1Style =  TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 24,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w600 );

  static const TextStyle langStyle = TextStyle(
      fontFamily: 'Inter',
      fontSize: 20,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.normal);

  static const TextStyle buttonTextStyle = TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 24,
      color: AppColors.gradientColor5,
      fontWeight: FontWeight.w600);

  static const TextStyle authButtonTextStyle = TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 20,
      color: AppColors.gradientColor3,
      fontWeight: FontWeight.w600);

}