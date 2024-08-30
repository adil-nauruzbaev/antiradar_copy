import 'dart:async';

import 'package:antiradar/presentation/view/radar/widgets/radar_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

@riverpod
Future<LocationPermission> locationPermission(LocationPermissionRef ref) async {
  return await Geolocator.checkPermission();
}

@riverpod
Stream<GeoPosition> location(LocationRef ref) async* {
  final permission = await ref.watch(locationPermissionProvider.future);
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw Exception('Permission denied');
  }
  final StreamController<GeoPosition> positionStream =
      StreamController<GeoPosition>();
  Geolocator.getPositionStream().listen((Position position) {
    positionStream.add(GeoPosition(
        latitude: position.latitude,
        longitude: position.longitude,
        heading: position.heading));
  });

  yield* positionStream.stream;
}
