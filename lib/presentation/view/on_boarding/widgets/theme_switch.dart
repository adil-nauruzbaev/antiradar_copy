import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/src/app_colors.dart';
import '../../../../utils/src/app_fonts.dart';
import '../../../view_model/settings/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeToggleSwitch extends ConsumerWidget {
  const ThemeToggleSwitch({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    bool initialValue = ref.watch(themeNotifierProvider) == AppTheme.dark;
    double toggleWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 60,
          width: toggleWidth,
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: AnimatedToggleSwitch<bool>.size(
            current: initialValue,
            values: const [false, true],
            indicatorSize: Size.infinite,
            customIconBuilder: (context, local, global) => Text(
              local.value ? loc.dark : loc.light,
              style: AppFonts.toggleTextStyle.copyWith(
                  color: Color.lerp(AppColors.toggleGrayText,
                      AppColors.gradientColor5, local.animationValue)),
            ),
            borderWidth: 0,
            style: ToggleStyle(
              indicatorColor: Colors.white,
              backgroundColor: AppColors.toggleGray,
              borderRadius: BorderRadius.circular(100),
              indicatorBoxShadow: [
                BoxShadow(
                  color: const Color(0xFF353535).withOpacity(0.18),
                  blurRadius: 13,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            selectedIconScale: 1,
            onChanged: (value) {
              ref.read(themeNotifierProvider.notifier)
                  .setTheme(value ? AppTheme.dark : AppTheme.light);
            },
          ),
        ),
      ],
    );
  }
}
