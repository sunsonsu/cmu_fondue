import 'package:cmu_fondue/domain/usecases/login.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:flutter/material.dart';

import 'views/init_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

enum AuthMode { init, login, register }

class AuthPage extends StatefulWidget {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

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
      // resizeToAvoidBottomInset: false, // ถ้าไม่อยากให้คีย์บอร์ดดันจอขึ้น
      body: Center(
        child: SingleChildScrollView(
          child: switch (mode) {
            AuthMode.init => InitView(
                onLoginTap: () => setState(() => mode = AuthMode.login),
                onRegisterTap: () => setState(() => mode = AuthMode.register),
              ),
            AuthMode.login => LoginView(
                loginUseCase: widget.loginUseCase,
                onSwitchToRegister: () => setState(() => mode = AuthMode.register),
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