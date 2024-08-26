import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabaseService {
  IsarDatabaseService._internal();

  static final IsarDatabaseService _instance = IsarDatabaseService._internal();

  factory IsarDatabaseService() {
    return _instance;
  }

  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      CountryModelSchema,
    ], directory: dir.path);
  }

  Isar get isarDB => isar;
}
