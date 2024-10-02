// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hello`
  String get hello {
    return Intl.message(
      'hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get selectCountry {
    return Intl.message(
      'Select country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Allow «Antiradar» to use your location?`
  String get allow {
    return Intl.message(
      'Allow «Antiradar» to use your location?',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allowBtn {
    return Intl.message(
      'Allow',
      name: 'allowBtn',
      desc: '',
      args: [],
    );
  }

  /// `Don't allow`
  String get dontAllowBtn {
    return Intl.message(
      'Don\'t allow',
      name: 'dontAllowBtn',
      desc: '',
      args: [],
    );
  }

  /// `Argentina`
  String get argentina {
    return Intl.message(
      'Argentina',
      name: 'argentina',
      desc: '',
      args: [],
    );
  }

  /// `Brazil`
  String get brazil {
    return Intl.message(
      'Brazil',
      name: 'brazil',
      desc: '',
      args: [],
    );
  }

  /// `Uruguay`
  String get uruguay {
    return Intl.message(
      'Uruguay',
      name: 'uruguay',
      desc: '',
      args: [],
    );
  }

  /// `Paraguay`
  String get paraguay {
    return Intl.message(
      'Paraguay',
      name: 'paraguay',
      desc: '',
      args: [],
    );
  }

  /// `Chile`
  String get chile {
    return Intl.message(
      'Chile',
      name: 'chile',
      desc: '',
      args: [],
    );
  }

  /// `English (US)`
  String get english {
    return Intl.message(
      'English (US)',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Español (A. Latina)`
  String get spanish {
    return Intl.message(
      'Español (A. Latina)',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `Português (BR)`
  String get portuguese {
    return Intl.message(
      'Português (BR)',
      name: 'portuguese',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get russian {
    return Intl.message(
      'Russian',
      name: 'russian',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Choose a style`
  String get chooseAStyle {
    return Intl.message(
      'Choose a style',
      name: 'chooseAStyle',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get contin {
    return Intl.message(
      'Continue',
      name: 'contin',
      desc: '',
      args: [],
    );
  }

  /// `START`
  String get start {
    return Intl.message(
      'START',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Antiradar`
  String get welcomeToAntiradar {
    return Intl.message(
      'Welcome to Antiradar',
      name: 'welcomeToAntiradar',
      desc: '',
      args: [],
    );
  }

  /// `Static`
  String get static {
    return Intl.message(
      'Static',
      name: 'static',
      desc: '',
      args: [],
    );
  }

  /// `chamber`
  String get chamber {
    return Intl.message(
      'chamber',
      name: 'chamber',
      desc: '',
      args: [],
    );
  }

  /// `STOP`
  String get stop {
    return Intl.message(
      'STOP',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Load points`
  String get loadPoints {
    return Intl.message(
      'Load points',
      name: 'loadPoints',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message(
      'Dark mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Free Version`
  String get freeVersion {
    return Intl.message(
      'Free Version',
      name: 'freeVersion',
      desc: '',
      args: [],
    );
  }

  /// `Pro Version`
  String get proVersion {
    return Intl.message(
      'Pro Version',
      name: 'proVersion',
      desc: '',
      args: [],
    );
  }

  /// `1 month`
  String get month {
    return Intl.message(
      '1 month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Limitless`
  String get limitless {
    return Intl.message(
      'Limitless',
      name: 'limitless',
      desc: '',
      args: [],
    );
  }

  /// `Version selection`
  String get versionSelection {
    return Intl.message(
      'Version selection',
      name: 'versionSelection',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signin {
    return Intl.message(
      'Sign In',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get repeat {
    return Intl.message(
      'Repeat password',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign In`
  String get signInText {
    return Intl.message(
      'Already have an account? Sign In',
      name: 'signInText',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign Up`
  String get signUpText {
    return Intl.message(
      'Don\'t have an account? Sign Up',
      name: 'signUpText',
      desc: '',
      args: [],
    );
  }

  /// `Choose a style`
  String get choose {
    return Intl.message(
      'Choose a style',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to place this action on map?`
  String get alertText {
    return Intl.message(
      'Are you sure you want to place this action on map?',
      name: 'alertText',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Here is the menu`
  String get tutorial0 {
    return Intl.message(
      'Here is the menu',
      name: 'tutorial0',
      desc: '',
      args: [],
    );
  }

  /// `Click on the START button to turn on Radar`
  String get tutorial1 {
    return Intl.message(
      'Click on the START button to turn on Radar',
      name: 'tutorial1',
      desc: '',
      args: [],
    );
  }

  /// `Press the STOP button to turn off the radar`
  String get tutorial2 {
    return Intl.message(
      'Press the STOP button to turn off the radar',
      name: 'tutorial2',
      desc: '',
      args: [],
    );
  }

  /// `Here you see warnings and restrictions`
  String get tutorial3 {
    return Intl.message(
      'Here you see warnings and restrictions',
      name: 'tutorial3',
      desc: '',
      args: [],
    );
  }

  /// `Here you can see your speed`
  String get tutorial4 {
    return Intl.message(
      'Here you can see your speed',
      name: 'tutorial4',
      desc: '',
      args: [],
    );
  }

  /// `Add mobile ambushes for up-to-date traffic information`
  String get tutorial5 {
    return Intl.message(
      'Add mobile ambushes for up-to-date traffic information',
      name: 'tutorial5',
      desc: '',
      args: [],
    );
  }

  /// `Customize the sound to make your journey more enjoyable`
  String get tutorial6 {
    return Intl.message(
      'Customize the sound to make your journey more enjoyable',
      name: 'tutorial6',
      desc: '',
      args: [],
    );
  }

  /// `Here you can mark cameras`
  String get tutorial7 {
    return Intl.message(
      'Here you can mark cameras',
      name: 'tutorial7',
      desc: '',
      args: [],
    );
  }

  /// `SKIP`
  String get skip {
    return Intl.message(
      'SKIP',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `SELECTED COUNTRY`
  String get selectedCountry {
    return Intl.message(
      'SELECTED COUNTRY',
      name: 'selectedCountry',
      desc: '',
      args: [],
    );
  }

  /// `DOWNLOADED COUNTRIES`
  String get downloadedCountries {
    return Intl.message(
      'DOWNLOADED COUNTRIES',
      name: 'downloadedCountries',
      desc: '',
      args: [],
    );
  }

  /// `Speed control`
  String get speedControl {
    return Intl.message(
      'Speed control',
      name: 'speedControl',
      desc: '',
      args: [],
    );
  }

  /// `Stationary camera`
  String get stationaryCamera {
    return Intl.message(
      'Stationary camera',
      name: 'stationaryCamera',
      desc: '',
      args: [],
    );
  }

  /// `Report an event`
  String get reportEvent {
    return Intl.message(
      'Report an event',
      name: 'reportEvent',
      desc: '',
      args: [],
    );
  }

  /// `Traffic jams`
  String get trafficJams {
    return Intl.message(
      'Traffic jams',
      name: 'trafficJams',
      desc: '',
      args: [],
    );
  }

  /// `Police`
  String get police {
    return Intl.message(
      'Police',
      name: 'police',
      desc: '',
      args: [],
    );
  }

  /// `Crash`
  String get crash {
    return Intl.message(
      'Crash',
      name: 'crash',
      desc: '',
      args: [],
    );
  }

  /// `Hazard`
  String get hazard {
    return Intl.message(
      'Hazard',
      name: 'hazard',
      desc: '',
      args: [],
    );
  }

  /// `Road works`
  String get roadWorks {
    return Intl.message(
      'Road works',
      name: 'roadWorks',
      desc: '',
      args: [],
    );
  }

  /// `Card error`
  String get cardError {
    return Intl.message(
      'Card error',
      name: 'cardError',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
