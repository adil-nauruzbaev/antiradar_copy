import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/utils/src/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/speed/speed_service.dart';

class SpeedIndicator extends ConsumerWidget {
  const SpeedIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedAsyncValue = ref.watch(speedProvider);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Theme.of(context).radarColors.staticChamberStrokeColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: -1.5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 40,
        child: speedAsyncValue.when(
          data: (speed) => Text(
            ' ${speed.toStringAsFixed(0)} ',
            style: AppFonts.sfProMedium.copyWith(fontSize: 28, color: Colors.black),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
