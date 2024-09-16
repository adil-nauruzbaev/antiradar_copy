import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'audio_channel.dart';

class VolumeButtons extends StatelessWidget {
  final GlobalKey key1;
  final GlobalKey key2;

  const VolumeButtons({super.key, required this.key1, required this.key2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).radarColors.volumeButtonColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            key: key1,
            child: SvgPicture.asset(
              'assets/icons/add.svg',
              colorFilter: ColorFilter.mode(
                  Theme.of(context).radarColors.volumeIconsColor,
                  BlendMode.srcIn),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 34),
          InkWell(
            key: key2,
            child: SvgPicture.asset('assets/icons/volumeup.svg',
                colorFilter: ColorFilter.mode(
                    Theme.of(context).radarColors.volumeIconsColor,
                    BlendMode.srcIn)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AudioChannelDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
