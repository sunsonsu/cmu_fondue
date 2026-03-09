/*
 * File: auth_page.dart
 * Description: The primary architectural container anchoring onboarding sequences securely.
 * Responsibilities: Replaces the viewport distinctly between branding introductions, credential submissions, and identity creation forms dynamically.
 * Dependencies: InitView, LoginView, RegisterView, LoginUseCase, RegisterUseCase
 * Lifecycle: Created exclusively when stream states emit null users, Disposed entirely when token streams verify authentication.
 * Author: Rachata
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/usecases/login.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:flutter/material.dart';

import 'views/init_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

/// Designates internally which UI component precisely maps out the active screen phase.
enum AuthMode { init, login, register }

/// Hosts the root authentication stack connecting identity forms distinctly.
class AuthPage extends StatefulWidget {
  /// The dependent logic instructing cloud validations securely.
  final LoginUseCase loginUseCase;

  /// The dependent logic defining password requirements strictly.
  final RegisterUseCase registerUseCase;

  /// Initializes a new instance of [AuthPage].
  const AuthPage({
    super.key,
    required this.loginUseCase,
    required this.registerUseCase,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthMode mode = AuthMode.init;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: switch (mode) {
            AuthMode.init => InitView(
              onLoginTap: () => setState(() => mode = AuthMode.login),
              onRegisterTap: () => setState(() => mode = AuthMode.register),
            ),
            AuthMode.login => LoginView(
              loginUseCase: widget.loginUseCase,
              onSwitchToRegister: () =>
                  setState(() => mode = AuthMode.register),
            ),
            AuthMode.register => RegisterView(
              registerUseCase: widget.registerUseCase,
              onSwitchToLogin: () => setState(() => mode = AuthMode.login),
            ),
          },
        ),
      ),
    );
  }
}
