import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:go_router/go_router.dart';

import 'dart:math' as math;

import '../../../../data/source/shared_preferences/shared_preferences_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';
import '../../../view_model/settings/theme_provider.dart';
import '../start_screen.dart';

class Tutorial {
  late TutorialCoachMark tutorialCoachMark;

  void showTutorial(BuildContext context) {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial(BuildContext context, WidgetRef ref) {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: ref.read(themeNotifierProvider) == AppTheme.light
          ? AppColors.lightTutorialShadowColor
          : AppColors.darkTutorialShadowColor,
      pulseEnable: false,
      textSkip: "SKIP",
      opacityShadow: 0.3,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        ref.read(firstNotifierProvider.notifier).setLearningComplete();
      },
      onSkip: () {
        ref.read(firstNotifierProvider.notifier).setLearningComplete();
        return true;
      },
      onClickTarget: (target) {
        switch (target.identify) {
          case "keyStartButton":
            context.push('/radar');
            break;
          default:
            print("Unknown target clicked");
        }
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "keyMenu",
        keyTarget: keyMenu,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            padding: const EdgeInsets.only(left: 36),
            builder: (context, controller) {
              return Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 250,
                      //color: Colors.orange,
                    ),
                    SvgPicture.asset(
                      'assets/icons/tutor_arrow.svg',
                      height: 35,
                    ),
                    Positioned(
                        left: 26,
                        top: 22,
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: AppColors.dialogTutorialColor,
                            ),
                            height: 15,
                            width: 15,
                          ),
                        )),
                    Positioned(
                      left: 32,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.dialogTutorialColor,
                        ),
                        height: 70,
                        width: 185,
                        child: Center(
                            child: Text(
                          'Here is the menu',
                          style:
                              AppFonts.sfProSemibold.copyWith(fontSize: 16),
                        )),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
        paddingFocus: 0,
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyStartButton",
        keyTarget: keyStartButton,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.zero,
            builder: (context, controller) {
              return Column(
                //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        height: 90,
                        width: 230,
                        //color: Colors.orange,
                      ),
                      Positioned(
                          left: 230 / 2 - 8,
                          top: 61,
                          child: Transform.rotate(
                            angle: math.pi / 4,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: AppColors.dialogTutorialColor,
                              ),
                              height: 15,
                              width: 15,
                            ),
                          )),
                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.dialogTutorialColor,
                          ),
                          height: 70,
                          width: 230,
                          child: Center(
                              child: Text(
                            'Click on the START button to turn on Radar',
                            style:
                                AppFonts.sfProSemibold.copyWith(fontSize: 16),
                          )),
                        ),
                      ),
                    ],
                  ),
                  Transform.rotate(
                    angle: math.pi,
                    child: SvgPicture.asset(
                      'assets/icons/tutor_arrow.svg',
                      height: 35,
                    ),
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
        paddingFocus: 0,
      ),
    );

    return targets;
  }
}
