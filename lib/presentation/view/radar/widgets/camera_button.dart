import 'package:antiradar/presentation/view/radar/widgets/alert_dialog.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/src/app_colors.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.gradientColor5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Consumer(
                builder: (context, ref, child) {
                  return placeActionDialog(context, (context, ref) => buildBottomSheet(context, ref));
                }
              );
            },
          );
        },
        child: SvgPicture.asset('assets/icons/camera2.svg'),
      ),
    );
  }
}

