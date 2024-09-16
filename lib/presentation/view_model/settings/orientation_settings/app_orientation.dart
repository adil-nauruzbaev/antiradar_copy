import 'package:flutter/services.dart';

class AppOrientation {
  static setOnlyVertical() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
  }

  static allowRotate() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}
