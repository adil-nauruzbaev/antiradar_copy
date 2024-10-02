// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:antiradar/data/source/shared_preferences/user_preferences.dart';

part 'shared_preferences_provider.g.dart';

@riverpod
class FirstNotifier extends _$FirstNotifier {
  @override
  FirstState build() =>
      FirstState(UserPref.isFirstTime, UserPref.isLearningComplete);
  void isFirstTime() {
    final isFirstTime = UserPref.isFirstTime;
    if (isFirstTime) {
      state = state.copyWith(isFirstTime: UserPref.isFirstTime = true);
    }
  }
  

// Метод для обновления isFirstTime на false
  void updateIsFirstTimeToFalse() {
    UserPref.isFirstTime = false; // Сохраняем в SharedPreferences
    state = state.copyWith(isFirstTime: false); // Обновляем состояние
  }
}

class FirstState {
  final bool? isFirstTime;
  final bool isLearningComplete;

  FirstState(
    this.isFirstTime,
    this.isLearningComplete,
  );

  FirstState copyWith({
    bool? isFirstTime,
    bool? isLearningComplete,
  }) {
    return FirstState(
      isFirstTime ?? this.isFirstTime,
      isLearningComplete ?? this.isLearningComplete,
    );
  }
}
