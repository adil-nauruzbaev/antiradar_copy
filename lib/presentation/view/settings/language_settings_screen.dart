import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../l10n/l10n.dart';
import '../../../utils/src/app_fonts.dart';
import '../../view_model/settings/app_colors_extension.dart';
import '../../view_model/settings/select_language/locale_provider.dart';

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

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
            loc.selectLanguage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Theme.of(context)
              .extension<AppColorsExtension>()!
              .settingsBackground,
        ),
        backgroundColor: Theme.of(context)
            .extension<AppColorsExtension>()!
            .settingsBackground,
        body: ListView(
          children: [
            ...LanguageEnum.values.map((e) => SettingTile(language: e)),
          ],
        ));
  }
}

class SettingTile extends ConsumerWidget {
  final LanguageEnum language;

  const SettingTile({super.key, required this.language});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    return Container(
      decoration: BoxDecoration(
        border: language != LanguageEnum.values.last
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
            language.loc(),
            style: AppFonts.interMedium.copyWith(fontSize: 18),
          ),
          leading: SvgPicture.asset(
            language.path(),
            width: 40,
            height: 40,
          ),
          trailing: Icon(
              currentLocale.languageCode == language.locale().languageCode
                  ? Icons.check
                  : null),
          dense: true,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
          contentPadding: const EdgeInsets.only(left: 24, right: 12),
          onTap: () {
            ref
                .read(localeNotifierProvider.notifier)
                .setLocale(language.locale());
          }
          //horizontalTitleGap: 25,
          ),
    );
  }
}
