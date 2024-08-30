import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'speed_service.g.dart';

@riverpod
Stream<double> speed(SpeedRef ref) async* {
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );

  await for (Position position
      in Geolocator.getPositionStream(locationSettings: locationSettings)) {
    double speedInMps = position.speed; // Скорость в метрах в секунду
    double speedInKph = speedInMps * 3.6; // Перевод в км/ч
    yield speedInKph;
  }
}
