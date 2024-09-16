// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:antiradar/data/source/database/isar_service.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_painter.dart';
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:antiradar/presentation/view_model/location/location_provider.dart';

class RadarImage extends ConsumerStatefulWidget {
  const RadarImage({super.key});

  @override
  ConsumerState<RadarImage> createState() => _RadarImageState();
}

class _RadarImageState extends ConsumerState<RadarImage> {
  Future<PictureInfo> _loadImage(String imageAssetPath) async {
    /*final ByteData data = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 40,
      targetWidth: 40,
    );
    var frame = await codec.getNextFrame();
    return frame.image;*/
    final svgString = await rootBundle.loadString(imageAssetPath);
    final picture = vg.loadPicture(SvgStringLoader(svgString), null);
    return picture;
  }

  Offset calculateOffset(Offset center, double radius, double angleInDegrees) {
    final angleInRadians = angleInDegrees * pi / -180;
    final dx = center.dx + radius * cos(angleInRadians);
    final dy = center.dy + radius * sin(angleInRadians);

    return Offset(dx, dy);
  }

  Offset calculateOffsetWithHeading(
      Offset center, double radius, double angleInDegrees, double heading) {
    final adjustedAngle = angleInDegrees - heading;
    return calculateOffset(center, radius, adjustedAngle);
  }

  // Offset calculateOffset(GeoPosition myLocation, GeoPosition cameraLocation) {
  //   double distance = calculateDistance(myLocation, cameraLocation);
  //   double bearing = calculateBearing(myLocation, cameraLocation);

  //   // Преобразуем расстояние в пиксели (например, 1 км = 100 пикселей)
  //   double pixelsPerMeter = 0.1; // Например, 0.1 пикселя на метр
  //   double offsetDistance = distance * pixelsPerMeter; // Расстояние в пикселях

  //   // Вычисляем смещение по осям X и Y
  //   double offsetX = offsetDistance * cos(_degreesToRadians(bearing));
  //   double offsetY = offsetDistance * sin(_degreesToRadians(bearing));

  //   return Offset(offsetX, offsetY);
  // }
  // double calculateBearing(GeoPosition point1, GeoPosition point2) {
  //   double lat1Rad = _degreesToRadians(point1.latitude);
  //   double lon1Rad = _degreesToRadians(point1.longitude);
  //   double lat2Rad = _degreesToRadians(point2.latitude);
  //   double lon2Rad = _degreesToRadians(point2.longitude);

  //   double dLon = lon2Rad - lon1Rad;

  //   double y = sin(dLon) * cos(lat2Rad);
  //   double x =
  //       cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(dLon);
  //   double bearing = atan2(y, x);

  //   return (bearing * 180 / pi + 360) % 360; // Возвращаем угол в градусах
  // }

  double calculateAngleFromCurrentLocation(
    GeoPosition point,
    GeoPosition currentLocation,
  ) {
    final deltaX = point.longitude - currentLocation.longitude;
    final deltaY = point.latitude - currentLocation.latitude;
    final angle = atan2(deltaY, deltaX) * 180 / pi;

    // Корректируем угол на основе heading
    final adjustedAngle = angle - (currentLocation.heading ?? 0);

    // Убедитесь, что угол остается в пределах 0-360 градусов
    return (adjustedAngle + 360) % 360;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double calculateDistance(GeoPosition point, GeoPosition currentLocation) {
    const double earthRadius = 6371; // Радиус Земли в километрах

    // Преобразуем градусы в радианы
    double lat1Rad = _degreesToRadians(point.latitude);
    double lon1Rad = _degreesToRadians(point.longitude);
    double lat2Rad = _degreesToRadians(currentLocation.latitude);
    double lon2Rad = _degreesToRadians(currentLocation.longitude);

    // Вычисляем разницу широт и долгот
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Применяем формулу Хаверсина
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

  Future<(List<Offset>, List<CountryModel>)> _getPoints(
      Size size, Offset center, GeoPosition currentLocation) async {
    const double maxDistanceKm = 0.6;
    final radius = min(size.width, size.height) / 0.8;
    final Isar isar = IsarDatabaseService().isarDB;

    List<CountryModel> positions = await isar.countryModels
        .where()
        .filter()
        .countryEqualTo('argentina')
        .findAll();

    List<Offset> points = [];

    for (var point in positions) {
      double angle = calculateAngleFromCurrentLocation(
        GeoPosition(
          latitude: point.lat!,
          longitude: point.long!,
        ),
        currentLocation,
      );
      double distance = calculateDistance(
          GeoPosition(
            latitude: point.lat!,
            longitude: point.long!,
          ),
          currentLocation);

      // Преобразуем дистанцию в пиксели относительно радиуса радара
      double distanceInPixels = (distance / maxDistanceKm) * radius;
      points.add(calculateOffsetWithHeading(
          center, distanceInPixels, angle, currentLocation.heading!));
    }

    return (points, positions);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: FutureBuilder<PictureInfo>(
        future: _loadImage('assets/icons/pin.svg'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              snapshot.data == null) {
            return const CircularProgressIndicator();
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final size = Size(constraints.maxWidth, constraints.maxHeight);
              final center = Offset(size.width / 2, size.height / 1.3);

              return ref.watch(locationProvider).when(
                data: (GeoPosition data) {
                  print(data.heading);
                  return FutureBuilder(
                    future: _getPoints(size, center, data),
                    builder: (context, snapshotPoints) {
                      if (snapshotPoints.connectionState !=
                              ConnectionState.done &&
                          snapshotPoints.data == null) {
                        return CircularProgressIndicator();
                      }
                      return CustomPaint(
                        painter: RadarPainter(
                          //image: snapshot.data!,
                          points: snapshotPoints.data?.$1 ?? [],
                          models: snapshotPoints.data?.$2 ?? [],
                          picture: snapshot.data!,
                          gradient: Theme.of(context).gradients.viewGradient!,
                          linesColor: Theme.of(context).appColors.radarColors!.linesColor!
                        ),
                      );
                    },
                  );
                },
                error: (Object error, StackTrace stackTrace) {
                  return CircularProgressIndicator();
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              );
            },
          );
        },
      ),
    );
  }
}

class GeoPosition {
  final double latitude;
  final double longitude;
  final double? heading;

  GeoPosition({
    required this.latitude,
    required this.longitude,
    this.heading,
  });

  @override
  String toString() =>
      'GeoPosition(latitude: $latitude, longitude: $longitude)';
}
