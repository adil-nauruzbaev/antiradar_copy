import 'package:antiradar/presentation/view/on_boarding/start_screen.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_image.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_painter.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/presentation/view_model/speed/speed_service.dart';
import 'package:antiradar/utils/app_colors.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey keyStopButton = GlobalKey();
final GlobalKey keyStaticChamber = GlobalKey();
final GlobalKey keySpeed = GlobalKey();
final GlobalKey keyAddButton = GlobalKey();
final GlobalKey keyVolumeButton = GlobalKey();
final GlobalKey keyCameraButton = GlobalKey();

class RadarScreen extends ConsumerStatefulWidget {
  const RadarScreen({super.key});

  @override
  ConsumerState<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends ConsumerState<RadarScreen> {
  @override
  Widget build(BuildContext context) {
    final speedAsyncValue = ref.watch(speedProvider);
    final loc = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop){
          return;
        }
        var tutorial = keyTutorial.currentState!.tutorial;
        if (tutorial.isShowing && tutorial.currentIndex == 2) {
          tutorial.tutorialCoachMark.goTo(1);
          context.pop();
        } else if (tutorial.isShowing && tutorial.currentIndex != 0) {
          tutorial.tutorialCoachMark.previous();
          tutorial.currentIndex -= 1;
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient:
                  Theme.of(context).extension<GradientExtension>()?.gradient),
          child: Stack(
            children: [
              const RadarImage(),
              // Camera button
              Positioned(
                left: 16,
                bottom: 240,
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    key: keyCameraButton,
                    backgroundColor: AppColors.gradientColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: AppColors
                                .alertColor, // Dark background for the dialog
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            content: SizedBox(
                              width: 300,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 12),
                                  SvgPicture.asset('assets/icons/location.svg'),
                                  const SizedBox(height: 14),
                                  Text(loc.alertText,
                                      textAlign: TextAlign.center,
                                      style: AppFonts.langStyle
                                          .copyWith(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 52,
                                    width: 100,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            false); // Return false when 'No' is pressed
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors
                                            .whiteColor, // Gray for 'No' button
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      child: Text(
                                        loc.no,
                                        style: AppFonts.searchStyle.copyWith(
                                            color: AppColors.gradientColor5),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    height: 52,
                                    width: 100,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            true); // Return true when 'Yes' is pressed
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors
                                            .gradientColor5, // Blue for 'Yes' button
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      child: Text(
                                        loc.yes,
                                        style: AppFonts.searchStyle.copyWith(
                                            color: AppColors.whiteColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset('assets/icons/camera2.svg'),
                  ),
                ),
              ),
              // Plus and sound buttons
              Positioned(
                right: 16,
                bottom: 180,
                child: Container(
                  width: 70,
                  height: 130,
                  decoration: BoxDecoration(
                      color: AppColors.gradientColor9,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        key: keyAddButton,
                        child: SvgPicture.asset('assets/icons/add.svg'),
                        onTap: () {},
                      ),
                      const SizedBox(height: 34),
                      InkWell(
                        key: keyVolumeButton,
                        child: SvgPicture.asset('assets/icons/volumeup.svg'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              // Top status indicator
              Positioned(
                left: 16,
                top: 68,
                child: Container(
                  key: keyStaticChamber,
                  width: 242,
                  height: 100,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.gradientColor9,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '200 m\nStatic chamber',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Image.asset('assets/icons/camera.png')
                    ],
                  ),
                ),
              ),
              // Stop button
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: _buildStopButton(context, keyStopButton),
                ),
              ),
              // Circle counter
              Positioned(
                right: 16,
                top: 68,
                child: CircleAvatar(
                  key: keySpeed,
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: speedAsyncValue.when(
                    data: (speed) => Text(
                      ' ${speed.toStringAsFixed(0)} ',
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStopButton(BuildContext context, GlobalKey key) {
  return SizedBox(
    height: 60,
    width: 260,
    child: ElevatedButton(
      key: key,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gradientColor3,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        context.pop();
      },
      child: const Text('STOP',
          style: TextStyle(fontSize: 24, color: Colors.white)),
    ),
  );
}
