import 'package:antiradar/presentation/view_model/isar/models/argentina_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'argentina_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<ArgentinaModel>> argentinaModels(ArgentinaModelsRef ref) async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('argentina').get();
  return querySnapshot.docs
      .map((doc) => ArgentinaModel.fromFirestore(doc))
      .toList();
}
