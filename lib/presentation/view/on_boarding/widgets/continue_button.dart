import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';

class ContinueButton extends StatelessWidget {
  final String text;
  final String route;

  const ContinueButton({super.key, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      height: 60,
      width: 260,
      child: ElevatedButton(
        onPressed: () {
          context.push(route);
        },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          backgroundColor: AppColors.whiteColor,
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: AppFonts.buttonTextStyle,
        ),
      ),
    );
  }
}
