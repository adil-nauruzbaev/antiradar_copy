import 'package:antiradar/data/firebase/argentina_provider.dart';
import 'package:antiradar/data/source/database/country_pod.dart';
import 'package:antiradar/data/source/database/isar_service.dart';
import 'package:antiradar/presentation/router/app_router.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/continue_button.dart';
import 'package:antiradar/presentation/view/on_boarding/widgets/rotating_icon.dart';
import 'package:antiradar/presentation/view_model/isar/models/country_model.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:antiradar/utils/extensions/localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:isar/isar.dart';

enum CountryEnum {
  argentina('assets/icons/country_flags/Argentina.svg'),
  brazil('assets/icons/country_flags/Brazil.svg'),
  uruguay(
    'assets/icons/country_flags/Uruguay.svg',
  ),
  paraguay(
    'assets/icons/country_flags/Paraguay.svg',
  ),
  chile('assets/icons/country_flags/Chile.svg'),
  ;

  final String flagPath;

  const CountryEnum(this.flagPath);

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
}

enum DownloadEnum {
  isDefault,
  downloaded,
  downloading,
}

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
                    country: e.locale(),
                    flagPath: e.flagPath,
                    countryDownload: e.name,
                  ),
                )
                // _buildLanguageItem(
                //   context,
                //   loc.argentina,
                //   'assets/icons/country_flags/Argentina.svg',
                // ),
                // _buildLanguageItem(
                //   context,
                //   loc.brazil,
                //   'assets/icons/country_flags/Brazil.svg',
                // ),
                // _buildLanguageItem(
                //   context,
                //   loc.uruguay,
                //   'assets/icons/country_flags/Uruguay.svg',
                // ),
                // _buildLanguageItem(
                //   context,
                //   loc.paraguay,
                //   'assets/icons/country_flags/Paraguay.svg',
                // ),
                // _buildLanguageItem(
                //   context,
                //   loc.chile,
                //   'assets/icons/country_flags/Chile.svg',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DownloadWidget extends ConsumerStatefulWidget {
  const DownloadWidget({
    super.key,
    required this.countryDownload,
    required this.country,
    required this.flagPath,
  });
  final String countryDownload;
  final String country;
  final String flagPath;
  @override
  ConsumerState<DownloadWidget> createState() => _DownloadState();
}

class _DownloadState extends ConsumerState<DownloadWidget> {
  String get countryDownload => widget.countryDownload;

  late final StateProvider<DownloadEnum> downloadPod;

  @override
  void initState() {
    super.initState();
    downloadPod = StateProvider((ref) {
      final Isar isar = IsarDatabaseService().isarDB;
      final length = isar.countryModels
          .where()
          .filter()
          .countryEqualTo(countryDownload)
          .countSync();
      if (length > 0) {
        return DownloadEnum.downloaded;
      }
      return DownloadEnum.isDefault;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDownloaded = ref.watch(downloadPod);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 48, bottom: 24),
      title: Text(
        widget.country,
        style: AppFonts.langStyle,
      ),
      leading: SvgPicture.asset(
        widget.flagPath,
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
      onTap: isDownloaded == DownloadEnum.downloaded &&
              isDownloaded == DownloadEnum.downloading
          ? null
          : () async {
              try {
                ref
                    .read(downloadPod.notifier)
                    .update((state) => DownloadEnum.downloading);
                final country = widget.countryDownload;

                final models =
                    await ref.read(firebaseModelsProvider(country).future);
                await ref
                    .read(countryNotifierProvider(country).notifier)
                    .saveAll(models)
                    .whenComplete(() {
                  ref
                      .read(downloadPod.notifier)
                      .update((state) => DownloadEnum.downloaded);
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
