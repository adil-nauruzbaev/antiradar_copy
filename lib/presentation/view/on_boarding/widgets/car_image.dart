import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarImage extends StatelessWidget {
  final String pic;
  final bool isHorizontal;
  const CarImage({super.key, required this.pic, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SvgPicture.asset(
        height: isHorizontal ? MediaQuery.of(context).size.height / 2.5 : null,
        pic,
      ),
    );
  }
}
