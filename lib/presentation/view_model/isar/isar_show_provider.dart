import 'package:antiradar/presentation/view_model/isar/isar_provider.dart';
import 'package:antiradar/presentation/view_model/isar/models/argentina_model.dart';
import 'package:isar/isar.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_show_provider.g.dart';

@riverpod
Future<List<ArgentinaModel>> isarArgentinaModels(
    IsarArgentinaModelsRef ref) async {
  final isar = await ref.watch(isarProvider.future);
  return await isar.argentinaModels.where().findAll();
}
