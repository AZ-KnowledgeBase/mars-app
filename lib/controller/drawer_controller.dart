// controller/drawer_controller.dart
import 'package:flutter/material.dart';
import '../screens/start_screen.dart';
import '../screens/home_page.dart';
import '../screens/media_screen.dart';
import '../screens/map_screen.dart';
import '../screens/info_screen.dart';
import '../screens/saved_media_screen.dart';
import '../controller/auth_controller.dart';

class AppDrawerController {
  final AuthController _authController = AuthController();

  // Closes the drawer and navigates to the given screen
  void navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
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
      navigateTo(context, const InfoScreen());

  void goToSaved(BuildContext context) =>
      navigateTo(context, const SavedMediaScreen());

  // Signs the user out via AuthController then navigates to the start screen
  Future<void> logout(BuildContext context) async {
    await _authController.signOut();
    if (context.mounted) {
      navigateTo(context, const StartScreen());
    }
  }
}