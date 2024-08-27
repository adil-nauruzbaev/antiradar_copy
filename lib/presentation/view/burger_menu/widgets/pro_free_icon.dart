import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';

class ProFreeIcon extends StatelessWidget {
  final bool isFree;
  final double iconSize;

  const ProFreeIcon({super.key, required this.isFree, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: iconSize,
      width: iconSize,
      decoration: BoxDecoration(
          color: isFree ? AppColors.gradientColor5 : null,
          gradient: isFree
              ? null
              : const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE6B980),
              Color(0xFFEACDA3),
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: Center(
        child: Text(
          isFree ? 'FREE' : 'PRO',
          style: AppFonts.sfProSemibold
              .copyWith(color: AppColors.whiteColor, fontSize: 14),
        ),
      ),
    );
  }
}
