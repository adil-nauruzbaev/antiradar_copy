import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static const _isDarkKey = 'is_dark';
  static const _languageKey = 'language';
  static const _isLanguageDisplayedKey = 'is_language_displayed';
  static const _isCountriesDisplayedKey = 'is_countries_displayed';
  static const _isThemeDisplayedKey = 'is_theme_displayed';

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
      _prefs.setString(_languageKey, langCode);
  static String get language =>
      _prefs.getString(_languageKey) ?? 'en';

  static set isLanguageDisplayed(bool isLanguageDisplayed) =>
      _prefs.setBool(_isLanguageDisplayedKey, isLanguageDisplayed);
  static bool get isLanguageDisplayed =>
      _prefs.getBool(_isLanguageDisplayedKey) ?? true;

  static set isCountriesDisplayed(bool isCountriesDisplayed) =>
      _prefs.setBool(_isCountriesDisplayedKey, isCountriesDisplayed);
  static bool get isCountriesDisplayed =>
      _prefs.getBool(_isCountriesDisplayedKey) ?? true;

  static set isThemeDisplayed(bool isThemeDisplayed) =>
      _prefs.setBool(_isThemeDisplayedKey, isThemeDisplayed);
  static bool get isThemeDisplayed =>
      _prefs.getBool(_isThemeDisplayedKey) ?? true;


  static close() {
    _prefs.clear();
  }
}
