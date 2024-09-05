import 'package:antiradar/data/firebase/argentina_provider.dart';
import 'package:antiradar/data/source/database/country_pod.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/continue_button.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/rotating_icon.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/utils/app_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../view_model/country_download_status/country_download_provider.dart';


class CountrySelectScreen extends ConsumerWidget {
  const CountrySelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: ContinueButton(
        text: loc.add,
        route: '/allow-location',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient:
                  Theme.of(context).extension<GradientExtension>()?.gradient),
          child: SafeArea(
            child: Column(
              children: [
                const TopCountryBar(),
                const SizedBox(
                  height: 40,
                ),
                ...CountryEnum.values.map(
                  (e) => DownloadWidget(
                    country: e,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DownloadWidget extends ConsumerWidget {
  const DownloadWidget({super.key, required this.country});

  final CountryEnum country;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var downloadPod = ref.watch(countryDownloadNotifierProvider.notifier);
    final isDownloaded = ref.watch(countryDownloadNotifierProvider)[country]!;
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 48, bottom: 24),
      title: Text(
        country.locale(),
        style: AppFonts.langStyle,
      ),
      leading: SvgPicture.asset(
        country.path(),
        width: 40,
        height: 40,
      ),
      trailing: switch (isDownloaded) {
        DownloadEnum.isDefault =>
          const _LoadIcon(path: 'assets/icons/load.svg'),
        DownloadEnum.downloaded => const Icon(
            Icons.check,
            color: Colors.white,
          ),
        DownloadEnum.downloading => const RotatingIcon(),
      },
      onTap: isDownloaded == DownloadEnum.downloaded ||
              isDownloaded == DownloadEnum.downloading
          ? null
          : () async {
              try {
                downloadPod.setDownloadState(country, DownloadEnum.downloading);

                final countryName = country.name;

                final models =
                    await ref.read(firebaseModelsProvider(countryName).future);
                await ref
                    .read(countryNotifierProvider(countryName).notifier)
                    .saveAll(models)
                    .whenComplete(() {
                  downloadPod.setDownloadState(
                      country, DownloadEnum.downloaded);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('Points ${country.name} saved to storage')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
    );
  }
}

class _LoadIcon extends StatelessWidget {
  final String path;

  const _LoadIcon({required this.path});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      //'assets/icons/tick.svg',
      path,
      width: 20,
      height: 20,
    );
  }
}

class TopCountryBar extends ConsumerWidget {
  const TopCountryBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.only(left: 6, right: 6),
      height: 60,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // IconButton(
        //   onPressed: () {
        //     context.pop();
        //   },
        //   icon: SvgPicture.asset(
        //     'assets/icons/arrow.svg',
        //     width: 12,
        //     height: 20,
        //   ),
        // ),
        Text(
          loc.selectCountry,
          style: AppFonts.h3Style,
        ),
        const SizedBox(
          width: 12,
        )
      ]),
    );
  }
}
