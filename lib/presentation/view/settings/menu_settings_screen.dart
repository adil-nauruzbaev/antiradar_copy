import 'package:antiradar/presentation/view_model/auth/auth_provider.dart';
import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_colors.dart';  
import '../../view_model/settings/user_settings/settings_provider.dart';

class MenuSettingsScreen extends ConsumerWidget {
  const MenuSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final loc = AppLocalizations.of(context)!;
    final UserSettings userSettings = ref.watch(settingsNotifierProvider);

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
          loc.settings,
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
          SettingTile(
              text: loc.lang,
              path: 'assets/icons/settings_icons/globe.svg',
              value: userSettings.isLanguageDisplayed,
              onChanged: (value) {
                ref
                    .read(settingsNotifierProvider.notifier)
                    .setIsLanguageDisplayed(value);
              }),
          SettingTile(
              text: loc.loadPoints,
              path: 'assets/icons/settings_icons/geo.svg',
              value: userSettings.isCountriesDisplayed,
              onChanged: (value) {
                ref
                    .read(settingsNotifierProvider.notifier)
                    .setIsCountriesDisplayed(value);
              }),
          SettingTile(
            text: loc.darkMode,
            path: 'assets/icons/settings_icons/moon.svg',
            value: userSettings.isThemeDisplayed,
            onChanged: (value) {
              ref
                  .read(settingsNotifierProvider.notifier)
                  .setIsThemeDisplayed(value);
            },
            border: false,
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String text;
  final String path;
  final bool value;
  final Function(bool) onChanged;
  final bool border;

  const SettingTile(
      {super.key,
      required this.text,
      required this.path,
      required this.value,
      required this.onChanged,
      this.border = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border
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
          text,
          style: AppFonts.interMedium.copyWith(fontSize: 18),
        ),
        leading: SvgPicture.asset(
          path,
          width: 32,
          height: 32,
        ),
        trailing: CupertinoSwitch(
          activeColor: AppColors.gradientColor5,
          value: value,
          onChanged: onChanged,
        ),
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
        contentPadding: const EdgeInsets.only(left: 24, right: 12),
        //horizontalTitleGap: 25,
      ),
    );
  }
}
