import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';

class StopButton extends StatelessWidget {
  final GlobalKey buttonKey;

  const StopButton({super.key, required this.buttonKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 260,
      margin: const EdgeInsets.only(bottom: 60),
      child: ElevatedButton(
        key: buttonKey,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gradientColor5,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          context.pop();
        },
        child: Text('STOP',
            style: AppFonts.buttonTextStyle.copyWith(color: AppColors.whiteColor)),
      ),
    );
  }
}
