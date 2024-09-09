import 'package:antiradar/data/source/database/country_manager.dart';
import 'package:antiradar/data/source/database/isar_service.dart';
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_pod.g.dart';

@riverpod
class CountryNotifier extends _$CountryNotifier {
  late final CountryManager _manager;
  final Isar isar = IsarDatabaseService().isar;

  @override
  Stream<List<CountryModel>> build(String country) async* {
    _manager = CountryManager(isar: isar);
    List<CountryModel> countryList = <CountryModel>[];
    _manager.getAllWatch(country).listen((value) {
      countryList = value;
    });
    final querySnapshot = FirebaseFirestore.instance
        .collection(country)
        .snapshots()
        .map((convert) => convert.docs);

    querySnapshot.listen((value) {
      if (countryList.length < value.length) {
        print(countryList.length);
        saveAllExcept(
            countryList,
            value
                .map((toElement) =>
                    CountryModel.fromFirestore(toElement, country))
                .toList());
      } else if (countryList.length > value.length) {
        // Need to do
        // delete(
        //     countryList,
        //     value
        //         .map((toElement) =>
        //             CountryModel.fromFirestore(toElement, country))
        //         .toList());
      }
    });
    yield countryList;
    // yield* _manager.getAllWatch(country);
  }

  Future<void> saveAll(List<CountryModel> models) async {
    await CountryManager(isar: isar).createAll(models);
  }

  Future<void> delete(
      List<CountryModel> models, List<CountryModel> firestoreModels) async {
    final uidModels = models.map((element) => element.uid).toSet();
    final newModels = firestoreModels
        .where((element) => !uidModels.contains(element.uid))
        .toList();
    final ids = newModels.map((element) => element.id).toList();
    await CountryManager(isar: isar).deleteIds(ids);
  }

  Future<void> saveAllExcept(
      List<CountryModel> models, List<CountryModel> firestoreModels) async {
    final uidModels = models.map((element) => element.uid).toSet();
    final newModels = firestoreModels
        .where((element) => !uidModels.contains(element.uid))
        .toList();
    await CountryManager(isar: isar).createAll(newModels);
  }
}
