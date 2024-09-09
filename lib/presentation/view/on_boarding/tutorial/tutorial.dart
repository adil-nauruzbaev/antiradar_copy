import 'dart:ui';

import 'package:antiradar/utils/extensions/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:go_router/go_router.dart';

import 'dart:math' as math;

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';
import '../../../router/app_router.dart';
import '../../../view_model/learning/learning_provider.dart';
import '../../../view_model/settings/theme_provider.dart';
import '../../radar/radar_screen.dart';
import '../start_screen.dart';


class Tutorial {

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  List<String> texts = [];
  int currentIndex = 0;
  bool isShowing = false;

  void showTutorial(BuildContext context) {
    tutorialCoachMark.show(context: context);
    isShowing = true;
  }

  void createTutorial(BuildContext context, WidgetRef ref) {
    final loc = navigatorKey.currentState!.context.localization;
    texts = [
      loc.tutorial0,
      loc.tutorial1,
      loc.tutorial2,
      loc.tutorial3,
      loc.tutorial4,
      loc.tutorial5,
      loc.tutorial6,
      loc.tutorial7,
    ];
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: ref.read(themeNotifierProvider) == AppTheme.light
          ? AppColors.lightTutorialShadowColor
          : AppColors.darkTutorialShadowColor,
      pulseEnable: false,
      textSkip: loc.skip,
      opacityShadow: 0.3,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        ref.read(learningNotifierProvider.notifier).setLearningComplete();
        isShowing = false;
      },
      onSkip: () {
        ref.read(learningNotifierProvider.notifier).setLearningComplete();
        isShowing = false;
        return true;
      },
      onClickTarget: (target) {
        currentIndex = targets.indexOf(target) + 1;

        switch (target.identify) {
          case "keyStartButton":
            context.push('/radar');
            break;
          default:
        }
      },
      onClickOverlay: (target){
        currentIndex = targets.indexOf(target) + 1;}
    );
  }



  List<TargetFocus> _createTargets() {


    targets.add(targetFocus(
        widgetKey: keyMenu,
        identify: 'keyMenu',
        text: texts[0],
        padding: const EdgeInsets.only(left: 36),
        alignmentGeometry: Alignment.topLeft,
        contentAlign: ContentAlign.bottom,
        triangleLeft: 26,
        triangleTop: 22,
        containerLeft: 32,
        containerTop: 12,
        arrowAngle: 0));

    targets.add(targetFocus(
        widgetKey: keyStartButton,
        identify: 'keyStartButton',
        text: texts[1],
        enableOverlayTab: false,
        alignmentGeometry: Alignment.topCenter,
        contentAlign: ContentAlign.top,
        triangleBottom: 52,
        containerBottom: 58,
        arrowBottom: 5,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        identify: 'keyStopButton',
        widgetKey: keyStopButton,
        text: texts[2],
        enableOverlayTab: false,
        alignmentGeometry: Alignment.topCenter,
        contentAlign: ContentAlign.top,
        triangleBottom: 52,
        containerBottom: 58,
        arrowBottom: 5,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        widgetKey: keyStaticChamber,
        identify: 'keyStaticChamber',
        text: texts[3],
        padding: const EdgeInsets.only(left: 60),
        alignmentGeometry: Alignment.topLeft,
        contentAlign: ContentAlign.bottom,
        triangleLeft: 26,
        triangleTop: 50,
        arrowLeft: 27,
        containerTop: 56,
        arrowAngle: 0));

    targets.add(targetFocus(
        widgetKey: keySpeed,
        identify: 'keySpeed',
        text: texts[4],
        padding: const EdgeInsets.only(right: 10),
        alignmentGeometry: Alignment.centerRight,
        contentAlign: ContentAlign.left,
        containerRight: 50,
        triangleRight: 44,
        arrowAngle: math.pi / 2,
        radius: 40));

    targets.add(targetFocus(
        widgetKey: keyAddButton,
        identify: 'keyAddButton',
        text: texts[5],
        padding: const EdgeInsets.only(right: 45),
        alignmentGeometry: Alignment.bottomRight,
        contentAlign: ContentAlign.top,
        containerRight: 54,
        triangleRight: 48,
        triangleBottom: 60,
        arrowBottom: 30,
        radius: 5,
        paddingFocus: 43,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        widgetKey: keyVolumeButton,
        identify: 'keyVolumeButton',
        text: texts[6],
        padding: const EdgeInsets.only(right: 45),
        alignmentGeometry: Alignment.bottomRight,
        contentAlign: ContentAlign.top,
        containerRight: 54,
        triangleRight: 48,
        triangleBottom: 60,
        arrowBottom: 30,
        radius: 5,
        paddingFocus: 43,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        widgetKey: keyCameraButton,
        identify: 'keyCameraButton',
        text: texts[7],
        padding: const EdgeInsets.only(left: 10),
        alignmentGeometry: Alignment.centerLeft,
        contentAlign: ContentAlign.right,
        containerLeft: 40,
        triangleLeft: 34,
        arrowAngle: -math.pi / 2));

    return targets;
  }

  static TargetFocus targetFocus({
    required GlobalKey widgetKey,
    required String identify,
    required AlignmentGeometry alignmentGeometry,
    required ContentAlign contentAlign,
    required String text,
    double? triangleTop,
    double? triangleBottom,
    double? triangleLeft,
    double? triangleRight,
    double? containerTop,
    double? containerBottom,
    double? containerLeft,
    double? containerRight,
    double? arrowTop,
    double? arrowBottom,
    double? arrowLeft,
    EdgeInsets? padding,
    bool enableOverlayTab = true,
    double radius = 10,
    double paddingFocus = 0,
    required double arrowAngle,
  }) {
    final double maxWidth = (contentAlign == ContentAlign.left || contentAlign == ContentAlign.right) ? 180 : 230;
    return TargetFocus(
      identify: identify,
      keyTarget: widgetKey,
      enableOverlayTab: enableOverlayTab,
      contents: [
        TargetContent(
          align: contentAlign,
          padding: padding ?? EdgeInsets.zero,
          builder: (context, controller) {
            return Stack(
              alignment: alignmentGeometry,
              children: [
                Container(
                  height: 200,
                  width: 250,
                  //color: Colors.orange,
                ),
                Positioned(
                    left: triangleLeft,
                    right: triangleRight,
                    top: triangleTop,
                    bottom: triangleBottom,
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
                  top: containerTop,
                  bottom: containerBottom,
                  left: containerLeft,
                  right: containerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.dialogTutorialColor,
                        ),
                        child: Center(
                            child: Text(
                          text,
                          style: AppFonts.sfProSemibold.copyWith(fontSize: 16),
                        )),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: arrowLeft,
                  top: arrowTop,
                  bottom: arrowBottom,
                  child: Transform.rotate(
                    angle: arrowAngle,
                    child: SvgPicture.asset(
                      'assets/icons/tutor_arrow.svg',
                      height: 35,
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
      shape: ShapeLightFocus.RRect,
      radius: radius,
      paddingFocus: paddingFocus,
    );
  }
}
