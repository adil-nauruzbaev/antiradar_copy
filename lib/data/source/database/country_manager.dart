import 'package:antiradar/data/source/database/database_manager.dart';
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:isar/isar.dart';

class CountryManager implements DatabaseManager<CountryModel> {
  final Isar isar;

  CountryManager({required this.isar});

  @override
  Future<void> create({required CountryModel item}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<CountryModel>> getAll(String country) {
    return isar.countryModels
        .where()
        .filter()
        .countryEqualTo(country)
        .findAll();
  }

  Stream<List<CountryModel>> getAllWatch(String country) {
    return isar.countryModels.where().filter().countryEqualTo(country).watch();
  }

  Future<void> createAll(List<CountryModel> models) async {
    await isar.writeTxn(() async {
      await isar.countryModels.putAll(models);
    });
  }

  @override
  Future<void> update({required CountryModel item}) {
    throw UnimplementedError();
  }
}
