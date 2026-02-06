import 'package:cmu_fondue/application/pages/login_page.dart';
import 'package:cmu_fondue/application/pages/pokemon_page.dart';
import 'package:cmu_fondue/data/datasources/firebase_auth_data_source.dart';
import 'package:cmu_fondue/data/repositories/auth_repo_impl.dart';
import 'package:cmu_fondue/domain/usecases/login.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:cmu_fondue/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMU Fondue',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return const PokemonPage();
          }

          final authDataSource = FirebaseAuthDataSource();
          final authRepository = AuthRepoImpl(authDataSource);

          return LoginPage(
            loginUseCase: LoginUseCase(authRepository),
            registerUseCase: RegisterUseCase(authRepository),
          );
        },
      ),
    );
  }
}
