import 'package:cmu_fondue/application/pages/pokemon_page.dart';
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
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5D3891)),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5D3891)),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonPage(),
                      ),
                    ),
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
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
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
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5D3891)),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5D3891)),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
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
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5D3891)),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
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
                    onPressed: () => setState(() => mode = AuthMode.login),
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(200, 40)),
                      backgroundColor: WidgetStateProperty.all(Color(0xFF5D3891)),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text('Sign up', style: TextStyle(fontSize: 18)),
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
}
