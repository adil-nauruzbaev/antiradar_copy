import 'package:antiradar/data/source/shared_preferences/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';

class ContinueButton extends ConsumerWidget {
  final String text;
  final String route;
  final GlobalKey? buttonKey;


  const ContinueButton({
    super.key,
    required this.text,
    required this.route,
    this.buttonKey,
   
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      height: 60,
      width: 260,
      child: ElevatedButton(
        key: buttonKey,
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
