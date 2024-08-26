import 'dart:math';

import 'package:antiradar/presentation/view/on_boarding/widgets/continue_button.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/utils/app_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CountrySelectScreen extends ConsumerWidget {
  const CountrySelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: ContinueButton(
        text: loc.add,
        route: '',
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
                _buildLanguageItem(
                  context,
                  loc.argentina,
                  'assets/icons/country_flags/Argentina.svg',
                ),
                _buildLanguageItem(
                  context,
                  loc.brazil,
                  'assets/icons/country_flags/Brazil.svg',
                ),
                _buildLanguageItem(
                  context,
                  loc.uruguay,
                  'assets/icons/country_flags/Uruguay.svg',
                ),
                _buildLanguageItem(
                  context,
                  loc.paraguay,
                  'assets/icons/country_flags/Paraguay.svg',
                ),
                _buildLanguageItem(
                  context,
                  loc.chile,
                  'assets/icons/country_flags/Chile.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageItem(
      BuildContext context, String country, String flagPath) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 48, bottom: 24),
      title: Text(
        country,
        style: AppFonts.langStyle,
      ),
      leading: SvgPicture.asset(
        flagPath,
        width: 40,
        height: 40,
      ),
      trailing: Random().nextBool()
          ? const _LoadIcon(
              path: 'assets/icons/loaded.svg',
            )
          : const _LoadIcon(path: 'assets/icons/load.svg'),
      onTap: () {},
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
      padding: const EdgeInsets.only(left: 6, right: 24),
      height: 60,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: 12,
            height: 20,
          ),
        ),
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
