import 'package:antiradar/presentation/view_model/isar/models/argentina_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [ArgentinaModelSchema],
    directory: dir.path,
    name: 'my_database',
  );
}

@Riverpod(keepAlive: true)
Future<ArgentinaModelRepository> argentinaModelRepository(
    ArgentinaModelRepositoryRef ref) async {
  final isar = await ref.watch(isarProvider.future);
  return ArgentinaModelRepository(isar);
}

class ArgentinaModelRepository {
  final Isar _isar;

  ArgentinaModelRepository(this._isar);

  Future<void> addArgentinaModel(
      double long, double lat, String type, String speed) async {
    final argentinaModel = ArgentinaModel()
      ..long = long
      ..lat = lat
      ..type = type
      ..speed = speed;

    await _isar.writeTxn(() async {
      await _isar.argentinaModels.put(argentinaModel);
    });
  }

  Future<List<ArgentinaModel>> getAllArgentinaModels() async {
    return await _isar.argentinaModels.where().findAll();
  }
}
