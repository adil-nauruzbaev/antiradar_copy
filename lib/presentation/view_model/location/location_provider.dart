import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

@riverpod
Future<LocationPermission> locationPermission(LocationPermissionRef ref) async {
  return await Geolocator.checkPermission();
}

@riverpod
Future<Position> location(LocationRef ref) async {
  final permission = await ref.watch(locationPermissionProvider.future);
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw Exception('Permission denied');
  }
  return await Geolocator.getCurrentPosition();
}
