import 'package:antiradar/presentation/view/radar/widgets/radar_image.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_painter.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.volume_up),
                        color: Colors.white,
                        onPressed: () {},
                      ),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: 60,
                      height: 60,
                      child: const Icon(Icons.camera, color: Colors.white),
                    ),
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
                child: _buildStopButton(),
              ),
            ),
            // Circle counter
            const Positioned(
              right: 16,
              top: 68,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 26, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStopButton() {
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
      onPressed: () {},
      child: const Text('STOP',
          style: TextStyle(fontSize: 24, color: Colors.white)),
    ),
  );
}
