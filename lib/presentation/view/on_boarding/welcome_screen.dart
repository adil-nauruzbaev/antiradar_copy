import 'package:antiradar/presentation/view_model/settings/theme_provider.dart';
import 'package:antiradar/presentation/view_model/settings/select_language/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    final loc = AppLocalizations.of(context)!;
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.selectLanguage),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(loc.english),
            trailing: Icon(locale.languageCode == 'en' ? Icons.check : null),
            onTap: () => ref
                .read(localeNotifierProvider.notifier)
                .setLocale(const Locale('en', 'US')),
          ),
          ListTile(
            title: Text(loc.spanish),
            trailing: Icon(locale.languageCode == 'es' ? Icons.check : null),
            onTap: () => ref
                .read(localeNotifierProvider.notifier)
                .setLocale(const Locale('es', 'ES')),
          ),
          ListTile(
            title: Text(loc.portuguese),
            trailing: Icon(locale.languageCode == 'pt' ? Icons.check : null),
            onTap: () => ref
                .read(localeNotifierProvider.notifier)
                .setLocale(const Locale('pt', 'BR')),
          ),
          ListTile(
            title: Text(loc.russian),
            trailing: Icon(locale.languageCode == 'ru' ? Icons.check : null),
            onTap: () => ref
                .read(localeNotifierProvider.notifier)
                .setLocale(const Locale('ru', 'RU')),
          ),
          ElevatedButton(
            child: Text(
              theme == AppTheme.light ? loc.dark : loc.light,
            ),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).setTheme(
                    theme == AppTheme.light ? AppTheme.dark : AppTheme.light,
                  );
            },
          ),
          /*ElevatedButton(
            child: Text(loc.add),
            onPressed: () {
              context.push('/country-select');
            },
          ),*/
          ElevatedButton(
            child: const Text('Вход (почти красивый)'),
            onPressed: () {
              context.push('/auth');
            },
          ),
          ElevatedButton(
            child: Text('${loc.settings} (еще некрасивый)'),
            onPressed: () {
              context.push('/allow-location');
            },
          ),
        ],
      ),
    );
  }
}
