import 'package:flutter/foundation.dart';
import 'package:cmu_fondue/application/pages/dataconnect_test_querie_page.dart';
import 'package:cmu_fondue/application/pages/pokemon_page.dart';
import 'package:cmu_fondue/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dataconnect_generated/generated.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMU Fondue Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      // home: const PokemonPage(),
      home: const DataConnectTestQueryPage(),
    );
  }
}
