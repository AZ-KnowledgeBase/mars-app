// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/start_screen.dart';
import 'utility/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before Firebase initializes
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MarsApp());
}

class MarsApp extends StatelessWidget {
  const MarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mars App',
      theme: AppTheme.marsDarkTheme,
      home: const StartScreen(),
    );
  }
}