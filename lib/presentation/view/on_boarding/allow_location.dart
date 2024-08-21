import 'package:antiradar/presentation/view_model/location/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class AllowLocationScreen extends ConsumerWidget {
  const AllowLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationPermissionAsyncValue = ref.watch(locationPermissionProvider);
    final locationAsyncValue = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locationPermissionAsyncValue.when(
              data: (permission) {
                if (permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever) {
                  return ElevatedButton(
                    onPressed: () async {
                      LocationPermission permission =
                          await Geolocator.requestPermission();
                      ref.refresh(locationPermissionProvider);
                    },
                    child: const Text('Request Location Permission'),
                  );
                } else {
                  return const Text('Permission granted');
                }
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
            const SizedBox(height: 20),
            locationAsyncValue.when(
              data: (position) =>
                  Text('Location: ${position.latitude}, ${position.longitude}'),
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
