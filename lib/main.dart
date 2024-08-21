import 'package:antiradar/presentation/router/app_router.dart';
import 'package:antiradar/presentation/view_model/settings/theme_provider.dart';
import 'package:antiradar/presentation/view_model/settings/select_language/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    final theme = ref.watch(themeNotifierProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: themeData(theme),
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt'),
        Locale('ru'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
