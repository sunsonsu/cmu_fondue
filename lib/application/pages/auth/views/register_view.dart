/*
 * File: register_view.dart
 * Description: The primary onboarding form generating brand new user records securely within the system.
 * Responsibilities: 
 * - Captures initial identity fields including email and password.
 * - Enforces complex password matching validation logic.
 * - Submits user creation directives to the backend via the registration use case.
 * Author: Rachata 650510638 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Lifecycle: Created from [AuthPage] router upon intent, Disposed upon successful registration and token verification.
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
/// 
/// Interacts with [RegisterUseCase] to create new accounts. 
/// Validates that the password and confirmation password fields match before submission.
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
  /// Controls the email input text.
  final _emailController = TextEditingController();

  /// Controls the password input text.
  final _passwordController = TextEditingController();

  /// Controls the password confirmation input text.
  final _confirmPasswordController = TextEditingController();

  /// The active error message displayed for the email field.
  String? _emailError;

  /// The active error message displayed for the initial password field.
  String? _passwordError;

  /// The active error message displayed for the confirmation password field.
  String? _confirmPasswordError;

  /// Whether the registration process is currently in progress.
  bool _loading = false;

  /// Verifies structural completion blocking invalid forms before firing network tasks directly.
  /// 
  /// Validates input presence and ensures that the provided passwords match. 
  /// If valid, an asynchronous request is made to [widget.registerUseCase].
  /// 
  /// Throws an [InvalidEmailException] if the email format is rejected by the server.
  /// Throws a [WeakPasswordException] if the password does not meet security criteria.
  /// Throws an [EmailAlreadyInUseException] if the email is already registered.
  /// Throws an [InvalidCredentialsException] if generic verification fails.
  /// 
  /// Side effects:
  /// - Toggles the [_loading] state to disable the submit button during execution.
  /// - Manipulates [AppAuthProvider.suppressAuthState] to prevent premature navigation flashes.
  /// - Triggers a success [CustomSnackBar] upon successful account creation.
  /// - Resets error states like [_emailError] before each attempt.
  Future<void> _submit() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
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
    if (_confirmPasswordController.text.isEmpty) {
      _confirmPasswordError = 'กรุณายืนยันรหัสผ่าน';
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
        _confirmPasswordError = 'รหัสผ่านไม่ตรงกัน';
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
          message: 'ลงทะเบียนสำเร็จ! กรุณาเข้าสู่ระบบ',
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
        _passwordError = 'อีเมลหรือรหัสผ่านไม่ถูกต้อง';
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
          const SizedBox(height: 32),
          AuthTextField(
            controller: _confirmPasswordController,
            label: 'ยืนยันรหัสผ่าน',
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
            ),
            child: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'ลงทะเบียน',
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
              final isSmall = constraints.maxWidth < 320;
              if (isSmall) {
                return Column(
                  children: [
                    Text(
                      'มีบัญชีอยู่แล้ว?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kanit(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onSwitchToLogin,
                      child: Text(
                        'เข้าสู่ระบบ',
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
                  text: 'มีบัญชีอยู่แล้ว? ',
                  style: GoogleFonts.kanit(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'เข้าสู่ระบบ',
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
