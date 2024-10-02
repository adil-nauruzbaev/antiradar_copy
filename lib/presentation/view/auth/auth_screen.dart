// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:antiradar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:antiradar/presentation/router/app_router.dart';
import 'package:antiradar/presentation/view/auth/widgets/custom_text_field.dart';
import 'package:antiradar/presentation/view/auth/widgets/lang_dropdown.dart';
import 'package:antiradar/presentation/view_model/auth/auth_provider.dart';
import 'package:antiradar/utils/src/app_fonts.dart';
import 'package:antiradar/utils/src/constants/ui_constants.dart';

import '../../../utils/src/app_colors.dart';
import '../../view_model/settings/gradient_extension.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  late StateProvider<AuthState> authStateProvider;

  @override
  void initState() {
    super.initState();
    authStateProvider =
        StateProvider<AuthState>((ref) => AuthState(email: '', password: ''));
  }

  //final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _isSignUp = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _authenticate() async {
    if (!_formKey.currentState!.validate()) {
      // Если форма не валидна, показываем сообщение и не продолжаем
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out the form correctly.')),
      );
      return;
    }
    final authState = ref.read(authStateProvider);
    try {
      if (_isSignUp) {
        // Регистрация

        await ref
            .read(authServiceProvider.notifier)
            .signUp(
              authState.email,
              _passwordController.text,
            )
            .whenComplete(() {
          if (mounted) context.go('/country-select');
        });

        // if (signUpResult == null) {
        //   // Переход только в случае успешной регистрации

        // } else {
        //   // Отображение ошибки регистрации
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Sign-up failed: $signUpResult')),
        //   );
        // }
      } else {
        // Вход

        await ref
            .read(authServiceProvider.notifier)
            .signIn(
              authState.email,
              _passwordController.text,
            )
            .whenComplete(() {
          if (mounted) context.go('/country-select');
        });
      }
    } catch (error) {
      // Отображение ошибки аутентификации
      log('ERROR:$error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  // Future<void> _signOut() async {
  //   try {
  //     await ref.read(authServiceProvider.notifier).signOut();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Signed out successfully!')),
  //     );
  //   } catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Sign out failed: $error')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authServiceProvider);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        height: context.height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            gradient:
                Theme.of(context).extension<GradientExtension>()?.gradient),
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _HandSVG(),
                  kSBH20,
                  Text(
                    _isSignUp ? loc.signup : loc.signin,
                    style: AppFonts.headlineStyle,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    //controller: _emailController,
                    onChanged: (value) => ref
                        .read(authStateProvider.notifier)
                        .update((state) => state.copyWith(email: value)),
                    hintText: loc.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите почту';
                      }
                      return null;
                    },
                  ),
                  kSBH20,
                  CustomTextField(
                    controller: _passwordController,
                    hintText: loc.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите пароль';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  Visibility(
                      visible: _isSignUp,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _repeatPasswordController,
                            hintText: loc.repeat,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, введите пароль';
                              } else if (value != _passwordController.text &&
                                  _isSignUp) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const LangDropDown(),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    width: context.width,
                    child: ElevatedButton(
                      onPressed: _authenticate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _isSignUp ? loc.signup : loc.signin,
                        style: AppFonts.authButtonTextStyle,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = !_isSignUp;
                      });
                    },
                    child: Text(_isSignUp ? loc.signInText : loc.signUpText,
                        style: AppFonts.textButtonStyle),
                  ),
                  // ElevatedButton(
                  //   onPressed: _signOut,
                  //   child: const Text('Sign out'),
                  // ),
                  // const SizedBox(height: 16),
                  // authState.when(
                  //   data: (user) => user != null
                  //       ? Text('Signed in as ${user.email}')
                  //       : const Text('Not signed in'),
                  //   loading: () => const CircularProgressIndicator(),
                  //   error: (e, _) => Text('Error: $e'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HandSVG extends StatelessWidget {
  const _HandSVG();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/waving-hand-svgrepo-com.svg',
      width: 80,
      height: 80,
    );
  }
}

class AuthState {
  final String email;
  final String password;
  AuthState({
    required this.email,
    required this.password,
  });

  AuthState copyWith({
    String? email,
    String? password,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
