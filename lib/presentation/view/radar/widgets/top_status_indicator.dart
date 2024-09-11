import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/presentation/view_model/settings/fonts_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopStatusIndicator extends StatelessWidget {
  final int meters;
  final String text;
  final String iconPath;

  const TopStatusIndicator({super.key, required this.text, required this.meters, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 242,
      height: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).radarColors.staticChamberColor,
        border: Border.all(
          color: Theme.of(context).radarColors.staticChamberStrokeColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$meters m',
                  style: Theme.of(context)
                      .appFonts
                      .staticChamberTextStyle!
                      .copyWith(fontSize: 18)),
              const SizedBox(
                height: 7,
              ),
              Text(
                text,
                style: Theme.of(context).appFonts.staticChamberTextStyle,
              ),
            ],
          ),
          SvgPicture.asset(iconPath)
        ],
      ),
    );
  }
}
