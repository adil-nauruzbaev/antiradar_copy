import 'package:antiradar/presentation/view/auth/auth_screen.dart';
import 'package:antiradar/presentation/view/on_boarding/allow_location.dart';
import 'package:antiradar/presentation/view/on_boarding/country_select_screen.dart';
import 'package:antiradar/presentation/view/start_screens/language_screen.dart';
import 'package:antiradar/presentation/view/test/iser.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:antiradar/presentation/view/on_boarding/welcome_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  // final shellNavigatorKey = GlobalKey<NavigatorState>();
  final router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/country-select',
          builder: (context, state) => const CountrySelectScreen(),
        ),
        GoRoute(
          path: '/allow-location',
          builder: (context, state) => const AllowLocationScreen(),
        ),
        GoRoute(
          path: '/language',
          builder: (context, state) => const LanguageScreen(),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/isar',
          builder: (context, state) => const SaveArgentinaDataPage(),
        ),
      ]);
  ref.onDispose(router.dispose);
  return router;
}
