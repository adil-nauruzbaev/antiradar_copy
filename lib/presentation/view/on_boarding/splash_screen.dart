import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static String routeLocation = '/splash';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffC1e4dd),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
