import 'dart:math';

import 'package:antiradar/data/source/shared_preferences/shared_preferences_provider.dart';
import 'package:antiradar/presentation/view/burger_menu/widgets/top_bar_version.dart';
import 'package:antiradar/presentation/view/burger_menu/widgets/version_selection.dart';
import 'package:antiradar/presentation/view_model/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../view_model/settings/theme_provider.dart';
import '../../view_model/settings/user_settings/settings_provider.dart';

class SettingTile {
  final String title;
  final String iconPath;
  final String? route;
  final bool showSwitch;
  final bool isVisible;

  SettingTile(
      {required this.title,
      this.showSwitch = false,
      this.isVisible = true,
      required this.iconPath,
      this.route});
}

class BurgerMenu extends ConsumerStatefulWidget {
  const BurgerMenu({super.key});

  @override
  _BurgerMenuState createState() => _BurgerMenuState();
}

class _BurgerMenuState extends ConsumerState<BurgerMenu> {
  final bool isFree = Random().nextBool();
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);
    final loc = AppLocalizations.of(context)!;
    final UserSettings userSettings = ref.watch(settingsNotifierProvider);
    final firstNotifier = ref.read(firstNotifierProvider.notifier);

    final settings = [
      SettingTile(
          title: loc.lang,
          iconPath: 'assets/icons/burger_icons/language.svg',
          isVisible: userSettings.isLanguageDisplayed,
          route: '/language-settings'),
      SettingTile(
          title: loc.loadPoints,
          iconPath: 'assets/icons/burger_icons/globe.svg',
          isVisible: userSettings.isCountriesDisplayed,
          route: '/country-settings'),
      SettingTile(
          title: loc.settings,
          iconPath: 'assets/icons/burger_icons/settings.svg',
          route: '/settings'),
      SettingTile(
          title: loc.about, iconPath: 'assets/icons/burger_icons/about.svg'),
      SettingTile(
          title: loc.share, iconPath: 'assets/icons/burger_icons/share.svg'),
      SettingTile(
          title: loc.darkMode,
          iconPath: 'assets/icons/burger_icons/moon.svg',
          isVisible: userSettings.isThemeDisplayed,
          showSwitch: true),
    ];

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.83,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                child: TopBarVersion(
                  isFree: isFree,
                  isTapped: isTapped,
                ),
                onTap: () {
                  setState(() {
                    isTapped = !isTapped;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              VersionSelection(isFree: isFree, isVisible: isTapped),
              const SizedBox(
                height: 24,
              ),
              ...settings.map(
                (e) => Visibility(
                  visible: e.isVisible,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 20, right: 40),
                    title: Text(
                      e.title,
                      style: AppFonts.interMedium.copyWith(fontSize: 18),
                    ),
                    horizontalTitleGap: 16,
                    leading: SvgPicture.asset(
                      e.iconPath,
                      width: 24,
                      height: 24,
                    ),
                    trailing: e.showSwitch ? const _DarkThemeToggle() : null,
                    onTap: () {
                      if (e.route != null) {
                        context.push(e.route!);
                      }
                    },
                  ),
                ),
              ),
              authState.when(
                data: (user) {
                  // Если пользователь авторизован, показываем кнопку выхода
                  if (user != null) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(left: 20, right: 40),
                      title: Text(
                        loc.logOut,
                        style: AppFonts.interMedium.copyWith(fontSize: 18),
                      ),
                      horizontalTitleGap: 16,
                      leading: const Icon(Icons.logout, size: 24, color: AppColors.iconGray,),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        GoRouter.of(context).go('/auth');
                      },
                    );
                  } else {
                    return const Text('Not logged in');
                  }
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DarkThemeToggle extends ConsumerWidget {
  const _DarkThemeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool initialValue = ref.watch(themeNotifierProvider) == AppTheme.dark;
    return CupertinoSwitch(
      activeColor: AppColors.gradientColor5,
      value: initialValue,
      onChanged: (value) {
        ref
            .read(themeNotifierProvider.notifier)
            .setTheme(value ? AppTheme.dark : AppTheme.light);
      },
    );
  }
}
