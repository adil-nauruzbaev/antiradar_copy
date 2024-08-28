// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<ui.Image> _loadImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 40,
      targetWidth: 40,
    );
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  Offset calculateOffset(Offset center, double radius, double angleInDegrees) {
    final angleInRadians = angleInDegrees * pi / 180;
    final dx = center.dx + radius * cos(angleInRadians);
    final dy = center.dy + radius * sin(angleInRadians);
    return Offset(dx, dy);
  }

  double calculateAngleFromCurrentLocation(
      GeoPosition point, GeoPosition currentLocation) {
    final deltaX = point.longitude - currentLocation.longitude;
    final deltaY = point.latitude - currentLocation.latitude;
    final angle = atan2(deltaY, deltaX);

    return angle * 180 / pi;
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

    List<CountryModel> Positions = await isar.countryModels
        .where()
        .filter()
        .countryEqualTo('argentina')
        .findAll();

    List<Offset> points = [];

    for (var point in Positions) {
      double angle = calculateAngleFromCurrentLocation(
          GeoPosition(
            latitude: point.lat!,
            longitude: point.long!,
          ),
          currentLocation);
      double distance = calculateDistance(
          GeoPosition(
            latitude: point.lat!,
            longitude: point.long!,
          ),
          currentLocation);

      // Преобразуем дистанцию в пиксели относительно радиуса радара
      double distanceInPixels = (distance / maxDistanceKm) * radius;
      points.add(calculateOffset(center, distanceInPixels, angle));
    }

    return (points, Positions);
  }

  late GeoPosition currentLocation;
  @override
  void initState() {
    super.initState();
    currentLocation = GeoPosition(
      latitude: -34.48445,
      longitude: -58.5182644,
    );
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {
        currentLocation = GeoPosition(
          latitude: currentLocation.latitude - 0.00001,
          longitude: currentLocation.longitude,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: FutureBuilder<ui.Image>(
        future: _loadImage('assets/icons/pin.png'),
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
                  print(currentLocation);
                  return FutureBuilder(
                    future: _getPoints(size, center, currentLocation),
                    builder: (context, snapshotPoints) {
                      if (snapshotPoints.connectionState !=
                              ConnectionState.done &&
                          snapshotPoints.data == null) {
                        return CircularProgressIndicator();
                      }
                      return CustomPaint(
                        painter: RadarPainter(
                          image: snapshot.data!,
                          points: snapshotPoints.data?.$1 ?? [],
                          models: snapshotPoints.data?.$2 ?? [],
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

  GeoPosition({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() =>
      'GeoPosition(latitude: $latitude, longitude: $longitude)';
}
