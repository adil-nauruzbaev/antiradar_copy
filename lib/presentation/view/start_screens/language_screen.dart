import 'package:antiradar/presentation/view/start_screens/widgets/add_button.dart';
import 'package:antiradar/presentation/view/start_screens/widgets/search_bar.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:antiradar/utils/app_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../view_model/settings/select_language/locale_provider.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final locale = ref.watch(localeNotifierProvider);

    return Scaffold(
      floatingActionButton: const AddButton(),
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
                const TopSearchBar(),
                const SizedBox(
                  height: 40,
                ),
                _buildLanguageItem(ref, context, 'en', loc.english, locale),
                _buildLanguageItem(ref, context, 'es', loc.spanish, locale),
                _buildLanguageItem(ref, context, 'pt', loc.portuguese, locale),
                _buildLanguageItem(ref, context, 'ru', loc.russian, locale),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageItem(WidgetRef ref, BuildContext context,
      String languageCode, String languageName, Locale currentLocale) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 6, bottom: 24),
      title: Text(
        languageName,
        style: AppFonts.langStyle,
      ),
      trailing:
          currentLocale.languageCode == languageCode ? const _TickIcon() : null,
      onTap: () => ref
          .read(localeNotifierProvider.notifier)
          .setLocale(Locale(languageCode)),
    );
  }
}

class _TickIcon extends StatelessWidget {
  const _TickIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/tick.svg',
      width: 16,
      height: 12,
    );
  }
}
