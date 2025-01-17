import 'package:antiradar/presentation/view/on_boarding/widgets/allow_button.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/continue_button.dart';
import 'package:antiradar/presentation/view_model/location/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/app_fonts.dart';
import '../../view_model/settings/gradient_extension.dart';

class AllowLocationScreen extends ConsumerWidget {
  const AllowLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationPermissionAsyncValue = ref.watch(locationPermissionProvider);
    final locationAsyncValue = ref.watch(locationProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: ContinueButton(
        text: loc.contin,
        route: '/theme-switch',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient:
                  Theme.of(context).extension<GradientExtension>()?.gradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  loc.welcomeToAntiradar,
                  style: AppFonts.h1Style,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  loc.allow,
                  style: AppFonts.bigTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              locationPermissionAsyncValue.when(
                data: (permission) {
                  if (permission == LocationPermission.denied ||
                      permission == LocationPermission.deniedForever) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AllowButton(
                          onPressed: () async {
                            LocationPermission permission =
                                await Geolocator.requestPermission();
                            ref.refresh(locationPermissionProvider);
                          },
                          text: loc.allowBtn
                        ),
                        AllowButton(
                          onPressed: () async {},
                          text: loc.dontAllowBtn
                        ),
                      ],
                    );
                  } else {
                    return const Text(
                      'Permission already granted',
                      style: AppFonts.langStyle,
                    );
                  }
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
              const SizedBox(height: 20),
              // locationAsyncValue.when(
              //   data: (position) => Text(
              //     'Location: ${position.latitude}, ${position.longitude}',
              //     style: const TextStyle(color: Colors.white),
              //   ),
              //   loading: () => const CircularProgressIndicator(),
              //   error: (err, stack) => Text('Error: $err'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
