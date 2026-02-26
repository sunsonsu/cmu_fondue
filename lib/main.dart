import 'package:cmu_fondue/application/pages/auth/auth_page.dart';
import 'package:cmu_fondue/application/pages/problem_detail.dart';
import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/data/repositories/problem_image_repo_impl.dart';
import 'package:cmu_fondue/data/repositories/problem_repo_impl.dart';
import 'package:cmu_fondue/data/repositories/user_repo_impl.dart';
import 'package:cmu_fondue/data/services/FirebaseStorageService.dart';
import 'package:cmu_fondue/data/services/notification_service.dart';
import 'package:cmu_fondue/domain/cache/cache_service.dart';
import 'package:cmu_fondue/domain/repositories/auth_repo.dart';
import 'package:cmu_fondue/domain/usecases/create_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/delete_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_problem_by_id_usecase.dart';
import 'package:cmu_fondue/domain/usecases/get_user_by_id_usecase.dart';
import 'package:cmu_fondue/domain/usecases/setup_notifications_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_upvote_usecase.dart';
import 'package:cmu_fondue/domain/usecases/update_problem_usecase.dart';
import 'package:cmu_fondue/data/services/cloud_functions_service.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:cloud_functions/cloud_functions.dart';
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

final cache = CacheService();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");

  // Initialize Notification Service
  await NotificationService().initialize();

  if (kDebugMode) {
    // Development mode: Configure Firebase Emulators
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : 'localhost';

    // Use production Auth but emulated Functions and DataConnect
    // FirebaseAuth.instance.useAuthEmulator(host, 9099); // ปิดเพื่อใช้ Auth จริง
    ConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, 9399);
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);

    // App Check with debug provider - required for Cloud Functions
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );

    print('🔧 Emulators: $host (Functions:5001, DataConnect:9399)');
    print('✅ Using production Firebase Auth');
  } else {
    // Production mode: Use Play Integrity & Device Check
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.deviceCheck,
    );
  }
  await cache.init();

  // create dependency for Authentacation Provider
  final authDataSource = FirebaseAuthDataSource(FirebaseAuth.instance);
  final authRepository = AuthRepositoryImpl(
    authDataSource,
    ConnectorConnector.instance,
  );

  final userRepository = UserRepoImpl(connector: ConnectorConnector.instance);

  // create dependency for Notification Setup
  final notificationService = NotificationService();
  final setupNotificationsUseCase = SetupNotificationsUseCase(
    notificationService,
    userRepository,
  );

  // create dependency for Problem Provider
  final problemRepository = ProblemRepoImpl(
    connector: ConnectorConnector.instance,
  );
  final problemImageRepository = ProblemImageRepoImpl(
    connector: ConnectorConnector.instance,
  );
  final storageService = FirebaseStorageService();

  final getProblemsUseCase = GetProblemsUseCase(problemRepository);
  final createProblemUseCase = CreateProblemUseCase(
    problemRepository: problemRepository,
    problemImageRepository: problemImageRepository,
    storageService: storageService,
  );
  final UpdateProblemUpvoteUseCase updateProblemUpvoteUseCase =
      UpdateProblemUpvoteUseCase(problemRepository);
  final deleteProblemUseCase = DeleteProblemUseCase(problemRepository);

  final updateProblemUseCase = UpdateProblemUseCase(problemRepository);

  final getUserByIdUseCase = GetUserByIdUseCase(userRepository);

  final getProblemByIdUseCase = GetProblemByIdUseCase(problemRepository);

  final cloudFunctionsService = CloudFunctionsService();

  // Setup notification navigation callback
  notificationService.setNavigationCallback((problemId) async {
    // รอจน navigator พร้อม
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (navigatorKey.currentContext == null) return;
    
    try {
      // ดึงข้อมูล problem จาก problemId
      final problem = await getProblemByIdUseCase(
        problemId: problemId,
        userId: null,
      );
      
      if (problem == null) {
        if (kDebugMode) {
          print('⚠️ Problem not found: $problemId');
        }
        return;
      }
      
      // Navigate ไปหน้า ProblemDetailPage
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => ProblemDetailPage(problem: problem),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error navigating to problem: $e');
      }
    }
  });

  // injection provider to app
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
        ChangeNotifierProvider(
          create: (_) =>
              AppAuthProvider(authRepository, setupNotificationsUseCase),
        ),

        ChangeNotifierProxyProvider<AppAuthProvider, ProblemProvider>(
          create: (_) => ProblemProvider(
            getProblemsUseCase,
            createProblemUseCase,
            updateProblemUpvoteUseCase,
            deleteProblemUseCase,
            updateProblemUseCase,
            getUserByIdUseCase,
            cloudFunctionsService,
          ),
          update: (_, auth, problemProvider) {
            final userId = auth.isAuthenticated ? auth.user?.id : null;

            return problemProvider!..updateUserId(userId);
          },
        ),
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
      navigatorKey: navigatorKey,
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
