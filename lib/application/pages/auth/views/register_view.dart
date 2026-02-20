import 'package:cmu_fondue/application/widgets/auth_text_field.dart';
import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {
  final RegisterUseCase registerUseCase;
  final VoidCallback onSwitchToLogin;

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

    try {
      await widget.registerUseCase(
        _emailController.text.trim(),
        _passwordController.text,
        _confirmPasswordController.text,
      );
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
          RichText(
            text: TextSpan(
              text: 'You already have an account? ',
              style: GoogleFonts.kanit(
                color: Colors.black,
                fontSize: 18,
              ),
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
          ),
        ],
      ),
    );
  }
}