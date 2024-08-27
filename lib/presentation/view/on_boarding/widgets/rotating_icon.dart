import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class RotatingIcon extends StatefulWidget {
  const RotatingIcon({super.key});

  @override
  _RotatingIconState createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: math.pi * 2,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: SvgPicture.asset(
            'assets/icons/loaded.svg',
            width: 20,
            height: 20,
          ),
        );
      },
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }
}