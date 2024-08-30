import 'package:antiradar/data/source/shared_preferences/user_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  UserSettings build() => UserSettings(
      isCountriesDisplayed: UserPref.isCountriesDisplayed,
      isLanguageDisplayed: UserPref.isLanguageDisplayed,
      isThemeDisplayed: UserPref.isThemeDisplayed);

  void setIsCountriesDisplayed(bool isCountriesDisplayed){
    state = state.copyWith(isCountriesDisplayed: isCountriesDisplayed);
    UserPref.isCountriesDisplayed = isCountriesDisplayed;
  }

  void setIsLanguageDisplayed(bool isLanguageDisplayed){
    state = state.copyWith(isLanguageDisplayed: isLanguageDisplayed);
    UserPref.isLanguageDisplayed = isLanguageDisplayed;
  }

  void setIsThemeDisplayed(bool isThemeDisplayed){
    state = state.copyWith(isThemeDisplayed: isThemeDisplayed);
    UserPref.isThemeDisplayed = isThemeDisplayed;
  }
}

class UserSettings {
  final bool isLanguageDisplayed;
  final bool isCountriesDisplayed;
  final bool isThemeDisplayed;

  const UserSettings({
    required this.isCountriesDisplayed,
    required this.isLanguageDisplayed,
    required this.isThemeDisplayed,
  });

  UserSettings copyWith({
    bool? isCountriesDisplayed,
    bool? isLanguageDisplayed,
    bool? isThemeDisplayed,
  }) {
    return UserSettings(
      isCountriesDisplayed: isCountriesDisplayed ?? this.isCountriesDisplayed,
      isLanguageDisplayed: isLanguageDisplayed ?? this.isLanguageDisplayed,
      isThemeDisplayed: isThemeDisplayed ?? this.isThemeDisplayed,
    );
  }
}

