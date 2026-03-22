// controller/drawer_controller.dart
import 'package:flutter/material.dart';
import '../screens/start_screen.dart';
import '../screens/home_page.dart';
import '../screens/media_screen.dart';
import '../screens/map_screen.dart';
import '../screens/settings_screen.dart';
import '../controller/auth_controller.dart';

class AppDrawerController {
   final AuthController _authController = AuthController();

  // All screen imports moved here from the View
  // Navigation logic extracted from app_drawer.dart into dedicated methods

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void goToHome(BuildContext context) =>
      navigateTo(context, const HomeScreen());

  void goToMedia(BuildContext context) =>
      navigateTo(context, const MediaScreen());

  void goToMap(BuildContext context) =>
      navigateTo(context, const MapScreen());

  void goToSettings(BuildContext context) =>
      navigateTo(context, const SettingsScreen());
  
  Future<void> logout(BuildContext context) async {
  await _authController.signOut();
    if (context.mounted) {                         
      navigateTo(context, const StartScreen());
    }
  }
}