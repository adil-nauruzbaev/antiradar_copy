import 'package:antiradar/presentation/view/on_boarding/widgets/car_image.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/theme_switch.dart';
import 'package:antiradar/utils/src/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/settings/gradient_extension.dart';
import 'widgets/continue_button.dart';

class ThemeSwitchScreen extends ConsumerWidget {
  const ThemeSwitchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: ContinueButton(
        text: loc.contin,
        route: '/start',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient:
                  Theme.of(context).extension<GradientExtension>()?.gradient),
          child: SafeArea(
            child: Column(
              children: [
                const CarImage(pic: 'assets/icons/car.svg'),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    loc.choose,
                    style: AppFonts.h2Style,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const ThemeToggleSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

