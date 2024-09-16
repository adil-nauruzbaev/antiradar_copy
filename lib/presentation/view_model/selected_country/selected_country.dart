import 'package:antiradar/presentation/view_model/country_download_status/country_download_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCountryProvider = StateProvider<CountryEnum>((ref) {
  return CountryEnum.values[0]; // Установите значение по умолчанию
});