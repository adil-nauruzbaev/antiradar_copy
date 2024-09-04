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
import '../../radar/radar_screen.dart';
import '../start_screen.dart';

class Tutorial {

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  int currentIndex = 0;
  bool isShowing = false;

  void showTutorial(BuildContext context) {
    tutorialCoachMark.show(context: context);
    isShowing = true;
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
        isShowing = false;
      },
      onSkip: () {
        ref.read(firstNotifierProvider.notifier).setLearningComplete();
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
        text: 'Here is the menu',
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
        text: 'Click on the START \nbutton to turn on Radar',
        enableOverlayTab: false,
        alignmentGeometry: Alignment.topCenter,
        contentAlign: ContentAlign.top,
        triangleTop: 61,
        arrowTop: 90,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        identify: 'keyStopButton',
        widgetKey: keyStopButton,
        text: 'Press the STOP button \nto turn off the radar',
        enableOverlayTab: false,
        alignmentGeometry: Alignment.topCenter,
        contentAlign: ContentAlign.top,
        triangleTop: 61,
        arrowTop: 90,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        widgetKey: keyStaticChamber,
        identify: 'keyStaticChamber',
        text: 'Here you see warnings \nand restrictions',
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
        text: 'Here you can see \nyour speed',
        padding: const EdgeInsets.only(right: 10, top: 34),
        alignmentGeometry: Alignment.centerRight,
        contentAlign: ContentAlign.left,
        containerRight: 40,
        triangleRight: 36,
        arrowAngle: math.pi / 2,
        radius: 40));

    targets.add(targetFocus(
        widgetKey: keyAddButton,
        identify: 'keyAddButton',
        text: 'Add mobile ambushes for \nup-to-date traffic \ninformation.',
        padding: const EdgeInsets.only(right: 45),
        alignmentGeometry: Alignment.centerRight,
        contentAlign: ContentAlign.top,
        containerRight: 54,
        triangleRight: 48,
        triangleTop: 32 ,
        radius: 5,
        paddingFocus: 43,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        widgetKey: keyVolumeButton,
        identify: 'keyVolumeButton',
        text: 'Customize the sound to \nmake your journey more \nenjoyable. ',
        padding: const EdgeInsets.only(right: 45),
        alignmentGeometry: Alignment.centerRight,
        contentAlign: ContentAlign.top,
        containerRight: 54,
        triangleRight: 48,
        triangleTop: 32 ,
        radius: 5,
        paddingFocus: 43,
        arrowAngle: math.pi));

    targets.add(targetFocus(
        widgetKey: keyCameraButton,
        identify: 'keyCameraButton',
        text: 'Here you can \nmark cameras ',
        padding: const EdgeInsets.only(left: 10, top: 23),
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
    double? triangleLeft,
    double? triangleRight,
    double? containerTop,
    double? containerLeft,
    double? containerRight,
    double? arrowTop,
    double? arrowLeft,
    EdgeInsets? padding,
    bool enableOverlayTab = true,
    double radius = 10,
    double paddingFocus = 0,
    required double arrowAngle,
  }) {
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
                  height: 130,
                  width: 250,
                  //color: Colors.orange,
                ),
                Positioned(
                    left: triangleLeft,
                    right: triangleRight,
                    top: triangleTop,
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
                  left: containerLeft,
                  right: containerRight,
                  child: IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.dialogTutorialColor,
                      ),
                      //height: 70,
                      child: Center(
                          child: Text(
                        text,
                        style: AppFonts.sfProSemibold.copyWith(fontSize: 16),
                      )),
                    ),
                  ),
                ),
                Positioned(
                  left: arrowLeft,
                  top: arrowTop,
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
