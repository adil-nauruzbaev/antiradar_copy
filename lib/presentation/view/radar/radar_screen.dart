import 'package:antiradar/data/firebase/sandbox_service.dart';
import 'package:antiradar/data/source/database/country_pod.dart';
import 'package:antiradar/presentation/view/on_boarding/start_screen.dart';
import 'package:antiradar/presentation/view/radar/widgets/audio_channel.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_image.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_painter.dart';
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:antiradar/presentation/view_model/location/location_provider.dart';
import 'package:antiradar/presentation/view_model/radar/models/sandbox_model.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/presentation/view_model/speed/speed_service.dart';
import 'package:antiradar/utils/app_colors.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
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
    final countryNotifier = ref.watch(countryNotifierProvider('argentina'));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
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
        //backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: Theme.of(context).gradients.radarGradient,),
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
                                      style: AppFonts.langStyle.copyWith(
                                          fontWeight: FontWeight.w500)),
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
                                        Navigator.of(context).pop(true);
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return Consumer(
                                              builder: (context, ref, child) {
                                                return buildBottomSheet(
                                                    context, ref);
                                              },
                                            );
                                          },
                                        ); // Return true when 'Yes' is pressed
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AudioChannelDialog();
                            },
                          );
                        },
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
                      SvgPicture.asset('assets/icons/camera.svg')
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

  Widget buildRadioOption(String option) {
    String _selectedOption = 'Automatically';
    return RadioListTile<String>(
      activeColor: Colors.blue,
      title: Text(
        option,
        style: const TextStyle(color: Colors.white),
      ),
      value: option,
      groupValue: _selectedOption,
      onChanged: (value) {
        setState(() {
          _selectedOption = value!;
        });
      },
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

final selectedSpeedProvider = StateProvider<int?>((ref) => 40);
Widget buildBottomSheet(BuildContext context, WidgetRef ref) {
  final locationAsyncValue = ref.watch(locationProvider);
  final loc = AppLocalizations.of(context)!;
  final selectedSpeed = ref.watch(selectedSpeedProvider);

  return Container(
    padding: const EdgeInsets.only(right: 16, left: 16, top: 20, bottom: 42),
    decoration: const BoxDecoration(
      color: AppColors.alertColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Speed control",
          style: AppFonts.h3Style.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 36),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 13),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.redColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset('assets/icons/camera3.svg'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),
        Text(
          "Stationary camera",
          style: AppFonts.h3Style.copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSpeedOption(context, ref, 40),
            buildSpeedOption(context, ref, 50),
            buildSpeedOption(context, ref, 60),
          ],
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              width: 170,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  loc.cancel,
                  style: AppFonts.bigTextStyle
                      .copyWith(color: AppColors.gradientColor5),
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              height: 60,
              width: 170,
              child: TextButton(
                onPressed: () {
                  // final sandboxData = SandboxModel(
                  //   country: 'ExampleCountry',
                  //   lat: locationAsyncValue.when(
                  //     data: (position) => position.latitude,
                  //     loading: () => 0.0,
                  //     error: (err, stack) => 0.0,
                  //   ),
                  //   long: locationAsyncValue.when(
                  //     data: (position) => position.longitude,
                  //     loading: () => 0.0,
                  //     error: (err, stack) => 0.0,
                  //   ),
                  //   speed: selectedSpeed!.toDouble(),
                  //   type: '',
                  // );

                  // ref.read(sandboxProvider).addSandboxData(sandboxData);
                  // Navigator.of(context).pop(true);

                  double calculateDistance(
                      double lat1, double lon1, double lat2, double lon2) {
                    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
                  }

                  void checkAndAddToCountry(
                      SandboxModel newPoint, WidgetRef ref) async {
                    final sandboxDataList =
                        await ref.read(sandboxProvider).getAllSandboxData();

                    List<SandboxModel> nearbyPoints = [];

                    for (var point in sandboxDataList) {
                      double distance = calculateDistance(
                        newPoint.lat,
                        newPoint.long,
                        point.lat,
                        point.long,
                      );

                      if (distance <= 100) {
                        nearbyPoints.add(point);
                      }
                    }

                    if (nearbyPoints.length >= 3) {
                      nearbyPoints.add(newPoint);

                      double avgLat = nearbyPoints
                              .map((point) => point.lat)
                              .reduce((a, b) => a + b) /
                          nearbyPoints.length;
                      double avgLong = nearbyPoints
                              .map((point) => point.long)
                              .reduce((a, b) => a + b) /
                          nearbyPoints.length;

                      final argentinaData = CountryModel(
                        lat: avgLat,
                        long: avgLong,
                        speed: newPoint.speed,
                        country: 'argentina',
                        createdAt: DateTime.now(),
                      );

                      try {
                        await FirebaseFirestore.instance
                            .collection('argentina')
                            .add(argentinaData.toFirestore());
                      } catch (e) {
                        print(e);
                      }
                    }
                  }

                  final sandboxData = SandboxModel(
                    country: 'argentina',
                    lat: locationAsyncValue.when(
                      data: (position) => position.latitude,
                      loading: () => 0.0,
                      error: (err, stack) => 0.0,
                    ),
                    long: locationAsyncValue.when(
                      data: (position) => position.longitude,
                      loading: () => 0.0,
                      error: (err, stack) => 0.0,
                    ),
                    speed: selectedSpeed!.toDouble(),
                    type: 'speed control',
                  );

                  ref.read(sandboxProvider).addSandboxData(sandboxData);
                  checkAndAddToCountry(sandboxData, ref);
                  Navigator.of(context).pop(true);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.gradientColor5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  loc.send,
                  style: AppFonts.bigTextStyle
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget buildSpeedOption(BuildContext context, WidgetRef ref, int speed) {
  final selectedSpeed = ref.watch(selectedSpeedProvider);

  return GestureDetector(
    onTap: () {
      ref.read(selectedSpeedProvider.notifier).state = speed;
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: selectedSpeed == speed
              ? AppColors.redColor
              : AppColors.whiteColor,
          width: 5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            "$speed",
            style: AppFonts.speedStyle,
          ),
        ),
      ),
    ),
  );
}
