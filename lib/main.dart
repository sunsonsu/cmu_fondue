import 'package:cmu_fondue/application/pages/auth/auth_page.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cmu_fondue/firebase_options.dart';

import 'package:cmu_fondue/data/datasources/firebase_auth_data_source.dart';
import 'package:cmu_fondue/data/repositories/auth_repo_impl.dart';

import 'package:cmu_fondue/domain/dataconnect_generated/generated.dart';
import 'package:cmu_fondue/domain/usecases/login.dart';
import 'package:cmu_fondue/domain/usecases/register.dart';
import 'package:cmu_fondue/application/pages/app_page.dart';
import 'package:cmu_fondue/application/theme/app_theme.dart';

// import 'package:cmu_fondue/application/pages/dataconnect_test_querie_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    // 10.0.2.2 is the 'localhost' for Android Emulators
    // 127.0.0.1 or localhost works for iOS/Web
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : 'localhost';
    ConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, 9399);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMU Fondue',
      theme: AppTheme.lightTheme,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          }

          final authDataSource = FirebaseAuthDataSource(FirebaseAuth.instance);
          final authRepository = AuthRepositoryImpl(authDataSource);

          return AuthPage(
            loginUseCase: LoginUseCase(authRepository),
            registerUseCase: RegisterUseCase(authRepository),
          );
        },
      ),
    );
  }
}
