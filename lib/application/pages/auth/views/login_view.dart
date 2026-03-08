/*
 * File: login_view.dart
 * Description: The primary identity verification form capturing returning user credentials securely.
 * Responsibilities: Captures raw email/password inputs, handles validation rules, and dispatches strict backend authentication attempts.
 * Dependencies: AuthTextField, LoginUseCase
 * Lifecycle: Created from AuthPage router upon intent, Disposed upon successful token stream verification propagating downwards.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/application/widgets/auth_text_field.dart';
import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:cmu_fondue/domain/usecases/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// Captures credentials coordinating rigorous backend validations dynamically exposing loading indications natively.
class LoginView extends StatefulWidget {
  /// The dependent logic instructing cloud validations securely.
  final LoginUseCase loginUseCase;

  /// The reactive closure triggered explicitly when redirecting back towards registration.
  final VoidCallback onSwitchToRegister;

  /// Initializes a new instance of [LoginView].
  const LoginView({
    super.key,
    required this.loginUseCase,
    required this.onSwitchToRegister,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _loading = false;

  /// Executes stringent validations rejecting empty fields securely before submitting native credentials upstream asynchronously.
  ///
  /// This operates asynchronously initiating deep architecture verifications actively. Formal failures mapping identically
  /// to invalid credentials or poor formats natively mutate internal UI rendering variables pushing identical messages
  /// underneath distinct text inputs exactly.
  ///
  /// Side effects:
  /// Rewrites [_emailError] and [_passwordError] distinctly upon rule breaking, toggles [_loading] phases, and fires [setState].
  Future<void> _submit() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool hasError = false;
    if (_emailController.text.trim().isEmpty) {
      _emailError = 'Please enter email';
      hasError = true;
    }
    if (_passwordController.text.isEmpty) {
      _passwordError = 'Please enter password';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _loading = true);

    try {
      // Ensure auth state is not suppressed so login can proceed normally
      context.read<AppAuthProvider>().suppressAuthState = false;

      await widget.loginUseCase(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } on InvalidEmailException {
      setState(() {
        _emailError = InvalidEmailException().message;
      });
    } on WeakPasswordException {
      setState(() {
        _passwordError = WeakPasswordException().message;
      });
    } on InvalidCredentialsException {
      setState(() {
        _emailError = ' ';
        _passwordError = InvalidCredentialsException().message;
      });
    } catch (e) {
      debugPrint('Login error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Image.asset('assets/images/cmu_logo.png', width: 160),
          const SizedBox(height: 36),

          AuthTextField(
            controller: _emailController,
            label: 'Email',
            errorText: _emailError,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (_) => setState(() => _emailError = null),
          ),
          const SizedBox(height: 32),
          AuthTextField(
            controller: _passwordController,
            label: 'Password',
            isPassword: true,
            errorText: _passwordError,
            onChanged: (_) => setState(() => _passwordError = null),
          ),

          const SizedBox(height: 16),
          const SizedBox(height: 60),

          ElevatedButton(
            onPressed: _loading ? null : _submit,
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(200, 40)),
              backgroundColor: WidgetStateProperty.all(const Color(0xFF5D3891)),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            child: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Login',
                    style: GoogleFonts.kanit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          ),

          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: GoogleFonts.kanit(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                  text: 'Sign up',
                  style: GoogleFonts.kanit(
                    color: const Color(0xFF5D3891),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onSwitchToRegister,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
