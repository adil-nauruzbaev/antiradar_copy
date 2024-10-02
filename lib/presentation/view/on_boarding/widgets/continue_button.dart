import 'package:antiradar/data/source/shared_preferences/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/src/app_colors.dart';
import '../../../../utils/src/app_fonts.dart';

class ContinueButton extends ConsumerWidget {
  final String text;
  final String route;
  final GlobalKey? buttonKey;
  final bool isHorizontal;

  const ContinueButton({super.key, required this.text, required this.route, this.buttonKey, this.isHorizontal = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Container(
      margin: EdgeInsets.only(bottom: isHorizontal ? 30 : 60),
      height: 60,
      width: 260,
      child: ElevatedButton(
        key: buttonKey,
        onPressed: () {
          if (route == '/start'){
            context.go(route);
          } else {
            context.push(route);
          }
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
