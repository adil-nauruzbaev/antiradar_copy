import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/src/app_colors.dart';
import '../../../../utils/src/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StopButton extends StatelessWidget {
  final GlobalKey buttonKey;
  final bool isHorizontal;

  const StopButton(
      {super.key, required this.buttonKey, required this.isHorizontal});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      height: 60,
      constraints: BoxConstraints(
        minWidth: isHorizontal ? 118 : 260,
        maxWidth: isHorizontal ? 160 : 260,
      ),
      margin: EdgeInsets.only(bottom: isHorizontal ? 26 : 60),
      child: ElevatedButton(
        key: buttonKey,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gradientColor5,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isHorizontal ? 5 : 10),
          ),
        ),
        onPressed: () {
          context.pop();
        },
        child: Text(loc.stop,
            style:
                AppFonts.buttonTextStyle.copyWith(color: AppColors.whiteColor)),
      ),
    );
  }
}
