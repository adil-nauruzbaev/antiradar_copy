import 'package:antiradar/presentation/view_model/selected_country/selected_country.dart';
import 'package:antiradar/presentation/view_model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/firebase/argentina_provider.dart';
import '../../../data/source/database/country_pod.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../view_model/country_download_status/country_download_provider.dart';
import '../../view_model/settings/app_colors_extension.dart';
import '../on_boarding/widgets/rotating_icon.dart';

class CountriesSettingsScreen extends ConsumerWidget {
  const CountriesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    // Получение текущего выбранного значения из `selectedCountryProvider`
    final selectedCountry = ref.watch(selectedCountryProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 14),
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          loc.loadPoints,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context)
            .extension<AppColorsExtension>()!
            .settingsBackground,
      ),
      backgroundColor:
          Theme.of(context).extension<AppColorsExtension>()!.settingsBackground,
      body: ListView(
        children: [
          _settingsText(loc.selectedCountry),
          SettingTile(country: selectedCountry),
          const SizedBox(height: 24),
          _settingsText(loc.downloadedCountries),
          ...CountryEnum.values.map((e) => SettingTile(country: e)),
        ],
      ),
    );
  }

  Widget _settingsText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7, left: 24),
      child: Text(
        text,
        style: AppFonts.interMedium
            .copyWith(fontSize: 14, color: AppColors.settingsText),
      ),
    );
  }
}

class SettingTile extends ConsumerWidget {
  final CountryEnum country;
  const SettingTile({super.key, required this.country});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var downloadPod = ref.watch(countryDownloadNotifierProvider.notifier);
    final isDownloaded = ref.watch(countryDownloadNotifierProvider)[country]!;

    return Container(
      decoration: BoxDecoration(
        border: country != CountryEnum.values.last
            ? Border(
                bottom: BorderSide(
                    color: Theme.of(context)
                        .extension<AppColorsExtension>()!
                        .settingsStrokeColor!))
            : null,
        color: Theme.of(context)
            .extension<AppColorsExtension>()!
            .settingsTileColor,
      ),
      child: ListTile(
        title: Text(
          country.locale(),
          style: AppFonts.interMedium.copyWith(fontSize: 18),
        ),
        leading: SvgPicture.asset(
          country.path(),
          width: 32,
          height: 32,
        ),
        trailing: switch (isDownloaded) {
          DownloadEnum.isDefault => InkWell(
              onTap: isDownloaded == DownloadEnum.downloaded ||
                      isDownloaded == DownloadEnum.downloading
                  ? null
                  : () async {
                      try {
                        downloadPod.setDownloadState(
                            country, DownloadEnum.downloading);

                        final countryName = country.name;

                        final models = await ref
                            .read(firebaseModelsProvider(countryName).future);
                        await ref
                            .read(countryNotifierProvider(countryName).notifier)
                            .saveAll(models)
                            .whenComplete(() {
                          downloadPod.setDownloadState(
                              country, DownloadEnum.downloaded);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data saved to Isar')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
              child: SvgPicture.asset(
                'assets/icons/load.svg',
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
              ),
            ),
          DownloadEnum.downloaded => const Icon(
              Icons.check,
            ),
          DownloadEnum.downloading => const RotatingIcon(),
        },
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
        contentPadding: const EdgeInsets.only(left: 24, right: 12),
        onTap: () {
          ref.read(selectedCountryProvider.notifier).state = country;
          ref.read(selectedCountryChangeNotifierProvider);
        },
      ),
    );
  }
}
