import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarImage extends StatelessWidget {
  final String pic;
  const CarImage({super.key, required this.pic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SvgPicture.asset(
        pic,
      ),
    );
  }
}
