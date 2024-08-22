import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../view_model/settings/select_language/locale_provider.dart';

class LangDropDown extends ConsumerWidget {
  const LangDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeNotifierProvider);

    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Locale>(
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.white,
            value: currentLocale,
            //style: TextStyle(color: Colors.white),
            dropdownColor: Colors.white,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                ref.read(localeNotifierProvider.notifier)
                    .setLocale(newLocale);
              }
            },
            items: [
              DropdownMenuItem<Locale>(
                value: const Locale('en', 'US'),
                child: Text(loc.english),
              ),
              DropdownMenuItem<Locale>(
                value: const Locale('es', 'ES'),
                child: Text(loc.spanish),
              ),
              DropdownMenuItem<Locale>(
                value: const Locale('pt', 'BR'),
                child: Text(loc.portuguese),
              ),
              DropdownMenuItem<Locale>(
                value: const Locale('ru', 'RU'),
                child: Text(loc.russian),
              ),
            ],
          ),
        ),
      ),
    );
  }
}