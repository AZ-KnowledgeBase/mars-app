// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/start_screen.dart';
import 'screens/home_page.dart';
import 'utility/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      // Checks Firebase auth state to decide the starting screen
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()  // User already logged in — go straight to home
          : const StartScreen(), // No session found — show login screen
    );
  }
}