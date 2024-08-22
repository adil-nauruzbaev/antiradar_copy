import 'package:antiradar/presentation/view_model/isar/isar_provider.dart';
import 'package:antiradar/presentation/view_model/isar/models/argentina_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_saver_provider.g.dart';

@Riverpod(keepAlive: true)
class IsarSaver extends _$IsarSaver {
  @override
  Future<void> build() async {}

  Future<void> saveArgentinaModels(List<ArgentinaModel> models) async {
    final isar = await ref.watch(isarProvider.future);

    await isar.writeTxn(() async {
      await isar.argentinaModels.putAll(models);
    });
  }
}
