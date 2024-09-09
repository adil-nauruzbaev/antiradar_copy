// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:antiradar/data/source/shared_preferences/user_preferences.dart';

part 'shared_preferences_provider.g.dart';

// @riverpod
// bool isFirstTime(IsFirstTimeRef ref) {
//   final isFirstTime = UserPref.isFirstTime;
//   if (isFirstTime) {
//     return UserPref.isFirstTime = true;
//   }

//   return isFirstTime;
// }

// @riverpod
// bool isLearningComplete(IsLearningCompleteRef ref) {
//   final isLearningComplete = UserPref.isLearningComplete;
//   if (isLearningComplete) {
//     return UserPref.isLearningComplete = true;
//   }

//   return isLearningComplete;
// }
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

  /*void setLearningComplete() {
    state = state.copyWith(isLearningComplete: true);
    UserPref.isLearningComplete = true;
  }

  void setLearningUnComplete() {
    state = state.copyWith(isLearningComplete: false);
    UserPref.isLearningComplete = false;
  }*/


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
