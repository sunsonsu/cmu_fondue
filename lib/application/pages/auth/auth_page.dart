/*
 * File: auth_page.dart
 * Description: The primary architectural container anchoring onboarding sequences securely for user authentication.
 * Responsibilities: 
 * - Switches the viewport between welcome branding, login credentials, and registration forms.
 * - Coordinates authentication use cases for logging in and creating new accounts.
 * - Manages the high-level authentication navigation state.
 * Author: Rachata 650510638 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Lifecycle: Created exclusively when authentication streams emit null users, Disposed entirely when token streams verify authentication.
 */

import 'package:cmu_fondue/domain/usecases/login.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:flutter/material.dart';

import 'views/init_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

/// Designates internal UI phases for the authentication flow.
enum AuthMode { 
  /// The initial welcome or landing screen mode.
  init, 
  /// The login credentials input mode.
  login, 
  /// The user registration input mode.
  register 
}

/// Hosts the root authentication stack connecting identity forms distinctly.
/// 
/// Acts as a state machine managing the transition between identity verification 
/// screens via the provided [loginUseCase] and [registerUseCase].
class AuthPage extends StatefulWidget {
  /// The dependent logic instructing cloud validations securely.
  final LoginUseCase loginUseCase;

  /// The dependent logic defining account creation requirements strictly.
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
  /// The current active mode determining which view to render.
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
