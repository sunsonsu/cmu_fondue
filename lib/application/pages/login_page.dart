import 'package:cmu_fondue/domain/exceptions/auth_exception.dart';
import 'package:cmu_fondue/domain/usecases/login.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum AuthMode { init, login, register }

class LoginPage extends StatefulWidget {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  const LoginPage({
    super.key,
    required this.loginUseCase,
    required this.registerUseCase,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthMode mode = AuthMode.init;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _loading = false;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: switch (mode) {
          AuthMode.init => _buildInit(),
          AuthMode.login => _buildLogin(),
          AuthMode.register => _buildRegister(),
        },
      ),
    );
  }

  Widget _buildInit() {
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        children: [
          const SizedBox(height: 190),
          Image(image: AssetImage('assets/images/cmu_logo.png'), width: 160),
          const SizedBox(height: 36),
          ElevatedButton(
            onPressed: () => setState(() => mode = AuthMode.login),
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(200, 40)),
              backgroundColor: WidgetStateProperty.all(Color(0xFF5D3891)),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: const Text('Login', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 30),
          RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: const TextStyle(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                  text: 'Sign up',
                  style: const TextStyle(
                    color: Color(0xFF5D3891),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() => mode = AuthMode.register);
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        children: [
          const SizedBox(height: 190),
          Image(image: AssetImage('assets/images/cmu_logo.png'), width: 160),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 36.0,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError,
                      filled: true,
                      fillColor: Colors.white,
                      border: _defaultBorder(),
                      enabledBorder: _defaultBorder(),
                      focusedBorder: _defaultBorder(),
                      errorBorder: _errorBorder(),
                      focusedErrorBorder: _errorBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _passwordController,
                    onChanged: (_) {
                      if (_passwordError != null) {
                        setState(() => _passwordError = null);
                      }
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError,
                      filled: true,
                      fillColor: Colors.white,
                      border: _defaultBorder(),
                      enabledBorder: _defaultBorder(),
                      focusedBorder: _defaultBorder(),
                      errorBorder: _errorBorder(),
                      focusedErrorBorder: _errorBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Forgot your password?',
                          style: const TextStyle(
                            color: Color(0xFF5D3891),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Forgot Password tapped');
                            },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 120),
                  ElevatedButton(
                    onPressed: _loading ? null : _login,
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(200, 40)),
                      backgroundColor: WidgetStateProperty.all(
                        Color(0xFF5D3891),
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: const TextStyle(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                  text: 'Sign up',
                  style: const TextStyle(
                    color: Color(0xFF5D3891),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() => mode = AuthMode.register);
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegister() {
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        children: [
          const SizedBox(height: 190),
          Image(image: AssetImage('assets/images/cmu_logo.png'), width: 160),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 36.0,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError,
                      filled: true,
                      fillColor: Colors.white,
                      border: _defaultBorder(),
                      enabledBorder: _defaultBorder(),
                      focusedBorder: _defaultBorder(),
                      errorBorder: _errorBorder(),
                      focusedErrorBorder: _errorBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _passwordController,
                    onChanged: (_) {
                      if (_passwordError != null) {
                        setState(() => _passwordError = null);
                      }
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError,
                      filled: true,
                      fillColor: Colors.white,
                      border: _defaultBorder(),
                      enabledBorder: _defaultBorder(),
                      focusedBorder: _defaultBorder(),
                      errorBorder: _errorBorder(),
                      focusedErrorBorder: _errorBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _confirmPasswordController,
                    onChanged: (_) {
                      if (_confirmPasswordError != null) {
                        setState(() => _confirmPasswordError = null);
                      }
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      errorText: _confirmPasswordError,
                      filled: true,
                      fillColor: Colors.white,
                      border: _defaultBorder(),
                      enabledBorder: _defaultBorder(),
                      focusedBorder: _defaultBorder(),
                      errorBorder: _errorBorder(),
                      focusedErrorBorder: _errorBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 68),
                  ElevatedButton(
                    onPressed: _loading ? null : _register,
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(200, 40)),
                      backgroundColor: WidgetStateProperty.all(
                        Color(0xFF5D3891),
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'You already have an account? ',
              style: const TextStyle(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                  text: 'Login',
                  style: const TextStyle(
                    color: Color(0xFF5D3891),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() => mode = AuthMode.login);
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
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

  Future<void> _register() async {
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
      // backend only
      debugPrint('Register error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  OutlineInputBorder _defaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF5D3891)),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    );
  }
}
