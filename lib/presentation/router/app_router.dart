import 'dart:developer';

import 'package:antiradar/data/source/shared_preferences/shared_preferences_provider.dart';
import 'package:antiradar/presentation/view/auth/auth_screen.dart';
import 'package:antiradar/presentation/view/on_boarding/allow_location.dart';
import 'package:antiradar/presentation/view/on_boarding/country_select_screen.dart';
import 'package:antiradar/presentation/view/on_boarding/splash_screen.dart';
import 'package:antiradar/presentation/view/on_boarding/theme_switch_screen.dart';
import 'package:antiradar/presentation/view/radar/radar_screen.dart';
import 'package:antiradar/presentation/view/settings/countries_settings_screen.dart';
import 'package:antiradar/presentation/view/settings/menu_settings_screen.dart';
import 'package:antiradar/presentation/view/test/iser.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:antiradar/presentation/view/on_boarding/welcome_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../view/on_boarding/start_screen.dart';
import '../view/settings/language_settings_screen.dart';

part 'app_router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final authProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authProvider);
  final firstPod = ref.watch(firstNotifierProvider);

  // Определяем, загружаются ли данные
  bool isLoading() {
    return authState.isRefreshing || authState.isLoading;
  }

  // Функция для вычисления начального маршрута
  String getInitialLocation() {
    if (authState.isRefreshing) {
      log('Firebase данные обновляются...');
      return '/splash'; // Показываем Splash экран пока не получим данные об авторизации
    }

    final isAuth = authState.value != null;
    log('isAuth: $isAuth'); // Логируем статус авторизации

    final isFirstTime = firstPod.isFirstTime ?? true;
    log('isFirstTime: $isFirstTime'); // Логируем статус первого запуска

    if (!isAuth) {
      return '/auth'; // Если не авторизован, направляем на экран авторизации
    }

    if (isFirstTime) {
      return '/country-select'; // Если это первый запуск, направляем на выбор страны
    }

    return '/'; // Иначе отправляем на главный экран
  }

  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: isLoading() ? '/splash' : getInitialLocation(), // Показываем splash пока данные загружаются
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashView(), // Экран загрузки
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
        builder: (context, state) => StartScreen(key: keyTutorial),
      ),
      GoRoute(
        path: '/isar',
        builder: (context, state) => const SaveArgentinaDataPage(),
      ),
      GoRoute(
        path: '/radar',
        builder: (context, state) => const RadarScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const MenuSettingsScreen(),
      ),
      GoRoute(
        path: '/country-settings',
        builder: (context, state) => const CountriesSettingsScreen(),
      ),
      GoRoute(
        path: '/language-settings',
        builder: (context, state) => const LanguageSettingsScreen(),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
}
