import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:antiradar/utils/extensions/localization.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/source/database/isar_service.dart';
import '../../router/app_router.dart';

part 'country_download_provider.g.dart';

enum DownloadEnum {
  isDefault,
  downloaded,
  downloading,
}

enum CountryEnum {
  argentina,
  brazil,
  uruguay,
  paraguay,
  chile;

  String locale() {
    final locale = navigatorKey.currentState!.context.localization;
    return switch (this) {
      argentina => locale.argentina,
      brazil => locale.brazil,
      uruguay => locale.uruguay,
      paraguay => locale.paraguay,
      chile => locale.chile,
    };
  }

  String path() {
    return switch (this) {
      argentina => 'assets/icons/country_flags/Argentina.svg',
      brazil => 'assets/icons/country_flags/Brazil.svg',
      uruguay => 'assets/icons/country_flags/Uruguay.svg',
      paraguay => 'assets/icons/country_flags/Paraguay.svg',
      chile => 'assets/icons/country_flags/Chile.svg',
    };
  }
}

@riverpod
class CountryDownloadNotifier extends _$CountryDownloadNotifier {
  final Isar isar = IsarDatabaseService().isarDB;

  @override
  Map<CountryEnum, DownloadEnum> build() {
    Map<CountryEnum, DownloadEnum> l = {};
    for (var value in CountryEnum.values) {
      if (isar.countryModels
          .where()
          .filter()
          .countryEqualTo(value.name).isEmptySync()){
        l[value] = DownloadEnum.isDefault;
      } else {
        l[value] = DownloadEnum.downloaded;
      }
    }
    return l;
  }

  void setDownloadState(CountryEnum country, DownloadEnum download) {
    state = {...state, country: download};
  }
}
