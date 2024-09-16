import 'package:antiradar/presentation/view_model/country_download_status/country_download_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSelectedCountry(CountryEnum country) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedCountry', country.name);
  print('Saved country: ${country.name}'); // Логирование
}

Future<CountryEnum> loadSelectedCountry() async {
  final prefs = await SharedPreferences.getInstance();
  final countryName = prefs.getString('selectedCountry');

  if (countryName != null) {
    return CountryEnum.values.firstWhere(
      (e) => e.name == countryName,
      orElse: () => CountryEnum.values[0],
    );
  } else {
    return CountryEnum.values[0];
  }
}

final selectedCountryFutureProvider = FutureProvider<CountryEnum>((ref) async {
  return await loadSelectedCountry();
});
final selectedCountryProvider = StateProvider<CountryEnum>((ref) {
  final asyncCountry = ref.watch(selectedCountryFutureProvider);

  return asyncCountry.when(
    data: (country) => country,
    loading: () =>
        CountryEnum.values[0], // Значение по умолчанию во время загрузки
    error: (_, __) =>
        CountryEnum.values[0], // Значение по умолчанию в случае ошибки
  );
});

final selectedCountryChangeNotifierProvider = Provider((ref) {
  final selectedCountry = ref.watch(selectedCountryProvider);

  // Сохраняем выбранную страну в SharedPreferences
  saveSelectedCountry(selectedCountry);

  return selectedCountry;
});
