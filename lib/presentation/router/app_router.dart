import 'dart:developer';

import 'package:antiradar/data/source/shared_preferences/shared_preferences_provider.dart';
import 'package:antiradar/presentation/view/auth/auth_screen.dart';
import 'package:antiradar/presentation/view/on_boarding/allow_location.dart';
import 'package:antiradar/presentation/view/on_boarding/country_select_screen.dart';
import 'package:antiradar/presentation/view/on_boarding/splash_screen.dart';
import 'package:antiradar/presentation/view/on_boarding/theme_switch_screen.dart';
import 'package:antiradar/presentation/view/radar/radar_screen.dart';
import 'package:antiradar/presentation/view/test/iser.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:antiradar/presentation/view/on_boarding/welcome_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../view/on_boarding/start_screen.dart';

part 'app_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final authProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

@riverpod
GoRouter router(RouterRef ref) {
  // final shellNavigatorKey = GlobalKey<NavigatorState>();

  final authService = ref.watch(authProvider);
  final firstPod = ref.watch(firstNotifierProvider);

  final router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/splash',
      redirect: (context, state) {
        if (authService.isLoading || authService.hasError) return null;

        final isAuth = authService.valueOrNull != null;

        final isLoggingIn = state.matchedLocation == '/auth';
        log('isLoggingIn $isLoggingIn');

        // if (isLoggingIn) return isAuth ? '/' : null;
        log('isAuth $isAuth');
        // if (firstPod.isFirstTime == true) return '/country-select';
        return isAuth
            ? state.matchedLocation == '/splash'
                ? (firstPod.isFirstTime ?? true)
                    ? '/country-select'
                    : null
                : null
            : '/auth';
      },
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashView(),
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
          path: '/auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/theme-switch',
          builder: (context, state) => const ThemeSwitchScreen(),
        ),
        GoRoute(
          path: '/start',
          builder: (context, state) => const StartScreen(),
        ),
        GoRoute(
          path: '/isar',
          builder: (context, state) => const SaveArgentinaDataPage(),
        ),
        GoRoute(
          path: '/radar',
          builder: (context, state) => RadarScreen(),
        ),
      ]);
  ref.onDispose(router.dispose);
  return router;
}
