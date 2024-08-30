import 'package:antiradar/presentation/view/burger_menu/burger_menu.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/car_image.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/settings/gradient_extension.dart';
import 'widgets/continue_button.dart';

class StartScreen extends ConsumerWidget {
  StartScreen({super.key});

  final GlobalKey<ScaffoldState> _startScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      drawer: const BurgerMenu(),
      key: _startScreenKey,
      floatingActionButton: ContinueButton(
        text: loc.start,
        route: '',
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 14),
                    child: IconButton(
                      onPressed: () {
                        _startScreenKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu, color: Colors.white, size: 36),
                    ),
                  ),
                ),
                const CarImage(pic: 'assets/icons/car2.svg'),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    loc.welcomeToAntiradar,
                    style: AppFonts.h2Style,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
