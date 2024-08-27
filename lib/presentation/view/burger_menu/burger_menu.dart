import 'dart:math';

import 'package:antiradar/presentation/view/burger_menu/widgets/top_bar_version.dart';
import 'package:antiradar/presentation/view/burger_menu/widgets/version_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../utils/app_fonts.dart';
import '../../../utils/asset_manager.dart';
import '../../view_model/settings/theme_provider.dart';

class BurgerMenu extends ConsumerStatefulWidget {
  const BurgerMenu({super.key});

  @override
  _BurgerMenuState createState() => _BurgerMenuState();
}

class _BurgerMenuState extends ConsumerState<BurgerMenu> {
  final bool isFree = Random().nextBool();
  bool isVisible = false;
  final iconsPaths = AssetManager.getBurgerIcons();


  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final settingsNames = [
      loc.lang,
      loc.loadPoints,
      loc.settings,
      loc.about,
      loc.share,
      loc.darkMode
    ];


    final bool theme = ref.watch(themeNotifierProvider) == AppTheme.light;
    return Drawer(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.83,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                child: TopBarVersion(isFree: isFree, isLightTheme: theme, isTapped: isVisible,),
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },),
              const SizedBox(
                height: 10,
              ),
              VersionSelection(
                  isFree: isFree, isVisible: isVisible, isLightTheme: theme),
              const SizedBox(height: 24,),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: settingsNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.only(left: 20),
                    title: Text(settingsNames[index], style: AppFonts.interMedium.copyWith(fontSize: 18), ),
                    horizontalTitleGap: 16,
                    leading: _SettingsIcon(path: iconsPaths[index],),
                  );
                }, separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 6,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  final String path;

  const _SettingsIcon({required this.path});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: 24,
      height: 24,
    );
  }
}
