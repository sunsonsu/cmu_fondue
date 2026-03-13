/*
 * File: login_view.dart
 * Description: The primary identity verification form capturing returning user credentials securely during the authentication phase.
 * Responsibilities: 
 * - Captures raw email and password inputs from the user.
 * - Handles input validation rules to ensure data completeness.
 * - Dispatches backend authentication attempts via the provided use case.
 * Author: Rachata 650510638 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Lifecycle: Created from [AuthPage] router upon intent, Disposed upon successful token stream verification.
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
/// 
/// Interacts with [LoginUseCase] to verify user identity. 
/// Displays specific error messages for invalid emails, weak passwords, or incorrect credentials.
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
  /// Controls the email input text.
  final _emailController = TextEditingController();

  /// Controls the password input text.
  final _passwordController = TextEditingController();

  /// The active error message displayed for the email field.
  String? _emailError;

  /// The active error message displayed for the password field.
  String? _passwordError;

  /// Whether the login process is currently in progress.
  bool _loading = false;

  /// Executes stringent validations rejecting empty fields before submitting credentials upstream.
  /// 
  /// Initiates an asynchronous call to [widget.loginUseCase]. If successful, the authentication 
  /// state is updated globally. If an [AuthException] occurs, it is caught and 
  /// mapped to user-friendly error strings.
  /// 
  /// Throws an [InvalidEmailException] if the email format is incorrect.
  /// Throws a [WeakPasswordException] if the password does not meet security standards.
  /// Throws an [InvalidCredentialsException] if the login attempt fails due to incorrect data.
  /// 
  /// Side effects:
  /// - Toggles the [_loading] state during the asynchronous operation.
  /// - Mutates [_emailError] and [_passwordError] to display feedback to the user.
  /// - Notifies the [AppAuthProvider] to stop suppressing authentication state updates.
  Future<void> _submit() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool hasError = false;
    if (_emailController.text.trim().isEmpty) {
      _emailError = 'กรุณากรอกอีเมล';
      hasError = true;
    }
    if (_passwordController.text.isEmpty) {
      _passwordError = 'กรุณากรอกรหัสผ่าน';
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
            label: 'อีเมล',
            errorText: _emailError,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (_) => setState(() => _emailError = null),
          ),
          const SizedBox(height: 32),
          AuthTextField(
            controller: _passwordController,
            label: 'รหัสผ่าน',
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
                    'เข้าสู่ระบบ',
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
              text: 'ยังไม่มีบัญชี? ',
              style: GoogleFonts.kanit(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                  text: 'ลงทะเบียน',
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
