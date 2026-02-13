import 'package:cmu_fondue/application/pages/auth/auth_page.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

// import 'package:cmu_fondue/application/pages/dataconnect_test_querie_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  if (kDebugMode) {
    // 10.0.2.2 is the 'localhost' for Android Emulators
    // 127.0.0.1 or localhost works for iOS/Web
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : 'localhost';
    ConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, 9399);
  }

  final authDataSource = FirebaseAuthDataSource(FirebaseAuth.instance);
  final authRepository = AuthRepositoryImpl(authDataSource);

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthRepository>.value(value: authRepository),

        ProxyProvider<AuthRepository, LoginUseCase>(
          update: (_, repo, _) => LoginUseCase(repo),
        ),
        ProxyProvider<AuthRepository, RegisterUseCase>(
          update: (_, repo, _) => RegisterUseCase(repo),
        ),

        ChangeNotifierProvider(create: (_) => AppAuthProvider(authRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMU Fondue',
      theme: AppTheme.lightTheme,
      home: Consumer<AppAuthProvider>(
        builder: (context, auth, _) {
          if (auth.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (auth.isAuthenticated) {
            return const HomePage();
          }

          return AuthPage(
            loginUseCase: context.read<LoginUseCase>(),
            registerUseCase: context.read<RegisterUseCase>(),
          );
        },
      ),
    );
  }
}
