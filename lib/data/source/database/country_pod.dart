import 'package:antiradar/data/source/database/country_manager.dart';
import 'package:antiradar/data/source/database/isar_service.dart';
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
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
    yield* _manager.getAllWatch(country);
  }

  Future<void> saveAll(List<CountryModel> models) async {
    CountryManager(isar: isar).createAll(models);
  }
}
