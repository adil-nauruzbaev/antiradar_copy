import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static late SharedPreferences _prefs;

  factory UserPref() => UserPref._internal();
  UserPref._internal();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static set isFirstTime(bool isFirstTime) =>
      _prefs.setBool('is_first_time', isFirstTime);
  static bool get isFirstTime => _prefs.getBool('is_first_time') ?? true;

  static set isLearningComplete(bool isLearningComplete) =>
      _prefs.setBool('is_learning_complete', isFirstTime);
  static bool get isLearningComplete =>
      _prefs.getBool('is_learning_complete') ?? false;

  static close() {
    _prefs.clear();
  }
}
