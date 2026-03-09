/*
 * File: register_view.dart
 * Description: The primary onboarding form generating brand new user records securely.
 * Responsibilities: Captures initial identity fields, strictly enforces complex password matching, and submits creation directives backward towards Firebase.
 * Dependencies: AuthTextField, RegisterUseCase
 * Lifecycle: Created from AuthPage router upon intent, Disposed upon successful token stream verifications.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/application/widgets/auth_text_field.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// Captures expansive credentials demanding explicit password confirmations dynamically preventing malformed entries natively.
class RegisterView extends StatefulWidget {
  /// The dependent logic instructing cloud creations strictly.
  final RegisterUseCase registerUseCase;

  /// The reactive closure triggered explicitly when redirecting back towards standard authentication.
  final VoidCallback onSwitchToLogin;

  /// Initializes a new instance of [RegisterView].
  const RegisterView({
    super.key,
    required this.registerUseCase,
    required this.onSwitchToLogin,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _loading = false;

  /// Verifies structural completion natively blocking invalid forms securely before firing network tasks directly asynchronously.
  ///
  /// This operates asynchronously initiating deep architecture creations actively. Throws highly specific anomalies
  /// matching identical domain bounds exposing textual corrections uniformly exactly mapping error strings downwards.
  ///
  /// Side effects:
  /// Rewrites formatting warnings spanning [_emailError], [_passwordError], and [_confirmPasswordError] exclusively,
  /// locks state rendering mechanisms by checking over [_loading], and fires [setState] continuously.
  Future<void> _submit() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
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
    if (_confirmPasswordController.text.isEmpty) {
      _confirmPasswordError = 'Please confirm your password';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _loading = true);

    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _confirmPasswordError = 'Password does not match';
        _loading = false;
      });
      return;
    }

    final authProvider = context.read<AppAuthProvider>();
    try {
      // Suppress auth state so the brief sign-in during registration
      // does not flash the HomePage.
      authProvider.suppressAuthState = true;

      await widget.registerUseCase(
        _emailController.text.trim(),
        _passwordController.text,
        _confirmPasswordController.text,
      );

      authProvider.suppressAuthState = false;

      // Registration succeeded — switch to login page
      if (mounted) {
        CustomSnackBar.showSuccess(
          context: context,
          message: 'Registration successful! Please log in.',
        );
        widget.onSwitchToLogin();
        return;
      }
    } on InvalidEmailException {
      setState(() {
        _emailError = InvalidEmailException().message;
      });
    } on WeakPasswordException {
      setState(() {
        _passwordError = WeakPasswordException().message;
      });
    } on EmailAlreadyInUseException {
      setState(() {
        _emailError = EmailAlreadyInUseException().message;
      });
    } on InvalidCredentialsException {
      setState(() {
        _emailError = ' ';
        _passwordError = 'Invalid email or password';
      });
    } catch (e) {
      debugPrint('Register error: $e');
    } finally {
      authProvider.suppressAuthState = false;
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
          const SizedBox(height: 32),
          AuthTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            isPassword: true,
            errorText: _confirmPasswordError,
            onChanged: (_) => setState(() => _confirmPasswordError = null),
          ),

          const SizedBox(height: 68),
          ElevatedButton(
            onPressed: _loading ? null : _submit,
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(200, 40)),
              backgroundColor: WidgetStateProperty.all(const Color(0xFF5D3891)),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: _loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Sign up',
                    style: GoogleFonts.kanit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          ),

          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 400;
              if (isSmall) {
                return Column(
                  children: [
                    Text(
                      'You already have an account?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onSwitchToLogin,
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          color: const Color(0xFF5D3891),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return RichText(
                text: TextSpan(
                  text: 'You already have an account? ',
                  style: GoogleFonts.kanit(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: GoogleFonts.kanit(
                        color: const Color(0xFF5D3891),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onSwitchToLogin,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
