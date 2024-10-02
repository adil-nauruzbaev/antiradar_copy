import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ProFreeIcon extends StatelessWidget {
  final bool isFree;
  final double iconSize;

  const ProFreeIcon({super.key, required this.isFree, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/${isFree ? 'free' : 'pro'}.svg',
      width: iconSize,
      height: iconSize,
    );
  }
}
