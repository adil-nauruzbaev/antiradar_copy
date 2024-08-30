import 'package:antiradar/presentation/view/radar/widgets/radar_image.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_painter.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/presentation/view_model/speed/speed_service.dart';
import 'package:antiradar/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RadarScreen extends ConsumerStatefulWidget {
  const RadarScreen({super.key});

  @override
  ConsumerState<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends ConsumerState<RadarScreen> {
  @override
  Widget build(BuildContext context) {
    final speedAsyncValue = ref.watch(speedProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient:
                Theme.of(context).extension<GradientExtension>()?.gradient),
        child: Stack(
          children: [
            RadarImage(),
            // Camera button
            Positioned(
              left: 16,
              bottom: 240,
              child: SizedBox(
                width: 70,
                height: 70,
                child: FloatingActionButton(
                  backgroundColor: AppColors.gradientColor3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.alertColor, // Dark background for the dialog
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          content: SizedBox(
                            width: 300,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Color(
                                        0xFF4B5563), // Darker gray for the icon background
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.gps_fixed,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Are you sure you want to place this action on map?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          false); // Return false when 'No' is pressed
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(
                                          0xFF4B5563), // Gray for 'No' button
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: Text('No',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          true); // Return true when 'Yes' is pressed
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(
                                          0xFF3B82F6), // Blue for 'Yes' button
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: Text('Yes',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                      child: SvgPicture.asset('assets/icons/add.svg'),
                      onTap: () {},
                    ),
                    const SizedBox(height: 34),
                    InkWell(
                      child: SvgPicture.asset('assets/icons/volumeup.svg'),
                      onTap: () {},
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
                    Image.asset('assets/icons/camera.png')
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
                child: _buildStopButton(context),
              ),
            ),
            // Circle counter
            Positioned(
              right: 16,
              top: 68,
              child: CircleAvatar(
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
    );
  }
}

Widget _buildStopButton(BuildContext context) {
  return SizedBox(
    height: 60,
    width: 260,
    child: ElevatedButton(
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
