import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:antiradar/data/source/shared_preferences/user_preferences.dart';

part 'learning_provider.g.dart';

@riverpod
class LearningNotifier extends _$LearningNotifier {
  @override
  bool build() => UserPref.isLearningComplete;

  void setLearningComplete() {
    state = true;
    UserPref.isLearningComplete = true;
  }

  void setLearningUnComplete() {
    state = false;
    UserPref.isLearningComplete = false;
  }
}
