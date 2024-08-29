import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static const _isDarkKey = 'is_dark';
  static const _language = 'language';

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

  static set isDark(bool isDark) =>
      _prefs.setBool(_isDarkKey, isDark);
  static bool get isDark =>
      _prefs.getBool(_isDarkKey) ?? false;

  static set language(String langCode) =>
      _prefs.setString(_language, langCode);
  static String get language =>
      _prefs.getString(_language) ?? 'en';


  static close() {
    _prefs.clear();
  }
}
