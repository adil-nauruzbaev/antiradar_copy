import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/l10n.dart';
import '../../../view_model/settings/select_language/locale_provider.dart';

class LangDropDown extends ConsumerWidget {
  const LangDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);

    final locales = L10n.locales;
    final languages = L10n.languages(context);

    final dropdownItems = locales
        .map((locale) => DropdownMenuItem<Locale>(
              value: locale,
              child: Text(
                languages[locales.indexOf(locale)],
                style: const TextStyle(color: Colors.black),
              ),
            ))
        .toList();

    selectedItemBuilder(BuildContext context) {
      return dropdownItems
          .map((item) => DropdownMenuItem<Locale>(
                value: item.value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    languages[locales.indexOf(item.value!)],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ))
          .toList();
    }

    return DropdownButton2<Locale>(
      isExpanded: true,
      items: dropdownItems,
      selectedItemBuilder: selectedItemBuilder,
      value: currentLocale,
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          ref.read(localeNotifierProvider.notifier).setLocale(newLocale);
        }
      },
      iconStyleData: const IconStyleData(
        iconSize: 24,
        iconEnabledColor: Colors.white,
      ),
      buttonStyleData: ButtonStyleData(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
      ),
      dropdownStyleData: const DropdownStyleData(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      underline: Container(height: 1, color: Colors.white),
      menuItemStyleData: const MenuItemStyleData(
        height: 50,
      ),
    );
  }
}
