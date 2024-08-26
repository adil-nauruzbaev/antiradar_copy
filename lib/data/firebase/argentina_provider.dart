import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'argentina_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<CountryModel>> firebaseModels(
    FirebaseModelsRef ref, String country) async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection(country).get();
  return querySnapshot.docs
      .map((doc) => CountryModel.fromFirestore(doc, country))
      .toList();
}
