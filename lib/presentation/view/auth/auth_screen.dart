import 'package:antiradar/presentation/view_model/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignUp = false;

  Future<void> _authenticate() async {
    try {
      if (_isSignUp) {
        await ref.read(authServiceProvider.notifier).signUp(
              _emailController.text,
              _passwordController.text,
            );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
      } else {
        await ref.read(authServiceProvider.notifier).signIn(
              _emailController.text,
              _passwordController.text,
            );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  Future<void> _signOut() async {
    try {
      await ref.read(authServiceProvider.notifier).signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed out successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _authenticate,
                child: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
              ),
              ElevatedButton(
                onPressed: _signOut,
                child: const Text('Sign out'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSignUp = !_isSignUp;
                  });
                },
                child: Text(_isSignUp
                    ? 'Already have an account? Sign In'
                    : 'Don\'t have an account? Sign Up'),
              ),
              const SizedBox(height: 16),
              authState.when(
                data: (user) => user != null
                    ? Text('Signed in as ${user.email}')
                    : Text('Not signed in'),
                loading: () => CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
