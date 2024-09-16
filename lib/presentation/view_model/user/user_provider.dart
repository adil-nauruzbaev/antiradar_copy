import 'package:antiradar/presentation/view_model/isar/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserProvider extends _$UserProvider {
  @override
  Future<UserModel> build() async {
    // Получаем текущего авторизованного пользователя
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('No user is signed in');
    }

    final userId = currentUser.uid;

    // Получаем документ пользователя по его UID из Firestore
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    // Парсим данные пользователя
    final userData = userDoc.data();
    if (userData != null) {
      return UserModel.fromMap(userData);  // Используем fromMap
    } else {
      throw Exception('User not found');
    }
  }
}