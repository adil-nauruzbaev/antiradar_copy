import 'package:antiradar/presentation/view_model/selected_country/selected_country.dart';
import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/presentation/view_model/settings/fonts_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../data/firebase/sandbox_service.dart';
import '../../../../utils/src/app_colors.dart';
import '../../../../utils/src/app_fonts.dart';
import '../../../view_model/isar/models/country_model.dart';
import '../../../view_model/location/location_provider.dart';
import '../../../view_model/radar/models/sandbox_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final selectedSpeedProvider = StateProvider<int?>((ref) => 40);

Widget buildBottomSheet(BuildContext context, WidgetRef ref) {
  final locationAsyncValue = ref.watch(locationProvider);
  final loc = AppLocalizations.of(context)!;
  final selectedSpeed = ref.watch(selectedSpeedProvider);
  final isHorizontal = MediaQuery.of(context).orientation == Orientation.landscape;
  final double decreaseIndex = isHorizontal ? 0.66 : 1;
  final selectedCountry = ref.watch(selectedCountryProvider);

  return Container(
    padding: EdgeInsets.only(right: 16, left: 16, top: 20, bottom: isHorizontal ? 20 : 40),
    decoration: BoxDecoration(
      color: Theme.of(context).radarColors.alertColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          loc.speedControl,
          style: Theme.of(context).appFonts.alertTextStyle2,
        ),
        SizedBox(height: isHorizontal ? 12 : 36),
        isHorizontal ? Row(
          children: [
            Container(
              height: 120 * decreaseIndex,
              width: 108 * decreaseIndex,
              padding: EdgeInsets.symmetric(vertical: 19 * decreaseIndex, horizontal: 13 * decreaseIndex),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * decreaseIndex),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.redColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0 * decreaseIndex),
                  child: SvgPicture.asset('assets/icons/camera3.svg'),
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Text(
              loc.stationaryCamera,
              style: Theme.of(context).appFonts.alertTextStyle3,
            ),
          ],
        ) : Column(
          children: [
            Container(
              height: 120,
              width: 108,
              padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
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
            SizedBox(height: isHorizontal ? 12 : 36),
            Text(
              loc.stationaryCamera,
              textAlign: TextAlign.center,
              style: Theme.of(context).appFonts.alertTextStyle3,
            ),
          ],
        ),
        const SizedBox(height: 36),
        isHorizontal ? SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSpeedOption(context, ref, 40),
              buildSpeedOption(context, ref, 50),
              buildSpeedOption(context, ref, 60),
              buildSpeedOption(context, ref, 80),
              buildSpeedOption(context, ref, 90),
              buildSpeedOption(context, ref, 100),
            ],
          ),
        ) : Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSpeedOption(context, ref, 40),
                buildSpeedOption(context, ref, 50),
                buildSpeedOption(context, ref, 60),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSpeedOption(context, ref, 80),
                buildSpeedOption(context, ref, 90),
                buildSpeedOption(context, ref, 100),
              ],
            ),
          ],
        ),
        SizedBox(height: isHorizontal ? 12 : 36),
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
                      side: BorderSide(
                        color: Theme.of(context).radarColors.staticChamberStrokeColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  loc.cancel,
                  style: AppFonts.sfProRegular.copyWith(fontSize: 24, color: AppColors.gradientColor5),
                ),
              ),
            ),
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
                        country: selectedCountry.toString(),
                        createdAt: DateTime.now(),
                      );

                      try {
                        await FirebaseFirestore.instance
                            .collection(selectedCountry.toString())
                            .add(argentinaData.toFirestore());
                      } catch (e) {
                        print(e);
                      }
                    }
                  }

                  final sandboxData = SandboxModel(
                    country: selectedCountry.toString(),
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
                  style: AppFonts.sfProRegular.copyWith(fontSize: 24, color: AppColors.whiteColor),
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
      constraints: const BoxConstraints(
        maxHeight: 100,
        maxWidth: 100,
        minHeight: 80,
        minWidth: 80
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: selectedSpeed == speed
              ? AppColors.redColor
              : AppColors.borderColor,
          width: 5,
        ),
      ),
      child: Center(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Text(
            "$speed",
            style: AppFonts.speedStyle,
          ),
        ),
      ),
    ),
  );
}
