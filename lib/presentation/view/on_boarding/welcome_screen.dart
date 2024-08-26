import 'package:antiradar/presentation/view/on_boarding/widgets/theme_switch.dart';
import 'package:antiradar/presentation/view_model/auth/auth_provider.dart';
import 'package:antiradar/presentation/view_model/settings/select_language/locale_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

//  Future<void> _signOut() async {
//       try {
//         await FirebaseAuth.instance.signOut();
//         // await ref.read(authServiceProvider.notifier).signOut();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Signed out successfully!')),
//         );
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Sign out failed: $error')),
//         );
//       }
//     }

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    final loc = AppLocalizations.of(context)!;

    //final theme = ref.watch(themeNotifierProvider);

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
            child: const Text('theme switch screen'),
            onPressed: () {
              context.push('/theme-switch');
            },
          ),
          ElevatedButton(
            child: const Text('Вход'),
            onPressed: () {
              context.push('/auth');
            },
          ),
          ElevatedButton(
            child: Text(loc.settings),
            onPressed: () {
              context.push('/allow-location');
            },
          ),
          ElevatedButton(
            child: const Text('выбор страны'),
            onPressed: () {
              context.push('/country-select');
            },
          ),
          const ThemeToggleSwitch(),
          ElevatedButton(
            child: const Text('list'),
            onPressed: () {
              context.push('/list');
            },
          ),
          ElevatedButton(
            child: const Text('isar'),
            onPressed: () {
              context.push('/isar');
            },
          ),
          ElevatedButton(
            child: const Text('exit'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
