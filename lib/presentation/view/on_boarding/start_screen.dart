import 'package:antiradar/data/source/shared_preferences/shared_preferences_provider.dart';
import 'package:antiradar/presentation/view/burger_menu/burger_menu.dart';
import 'package:antiradar/presentation/view/on_boarding/tutorial/tutorial.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/car_image.dart';
import 'package:antiradar/presentation/view_model/learning/learning_provider.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/settings/gradient_extension.dart';
import 'widgets/continue_button.dart';

final GlobalKey<ScaffoldState> startScreenKey = GlobalKey<ScaffoldState>();
final GlobalKey keyMenu = GlobalKey();
final GlobalKey keyStartButton = GlobalKey();
final keyTutorial = GlobalKey<_StartScreenState>();

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  final Tutorial tutorial = Tutorial();

  @override
  void initState() {
    super.initState();
    if (!ref.read(learningNotifierProvider)) {
      tutorial.createTutorial(context, ref);
      tutorial.showTutorial(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final firstNotifier = ref.read(firstNotifierProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        if (tutorial.isShowing && tutorial.currentIndex == 0) {
          tutorial.tutorialCoachMark.finish();
          ref.read(learningNotifierProvider.notifier).setLearningUnComplete();
          context.pop();
        } else if (tutorial.isShowing && tutorial.currentIndex != 0) {
          tutorial.tutorialCoachMark.previous();
          tutorial.currentIndex -= 1;
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        key: startScreenKey,
        drawer: const BurgerMenu(),
        floatingActionButton: ContinueButton(
          buttonKey: keyStartButton,
          text: loc.start,
          route: '/radar',
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
                        key: keyMenu,
                        onPressed: () {
                          startScreenKey.currentState!.openDrawer();
                        },
                        icon: const Icon(Icons.menu,
                            color: Colors.white, size: 36),
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
      ),
    );
  }
}
