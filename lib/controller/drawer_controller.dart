// controller/drawer_controller.dart
import 'package:flutter/material.dart';
import '../screens/start_screen.dart';
import '../screens/home_page.dart';
import '../screens/media_screen.dart';
import '../screens/map_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/forecast_screen.dart';

class AppDrawerController {
  // All screen imports moved here from the View
  // Navigation logic extracted from app_drawer.dart into dedicated methods

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void goToStart(BuildContext context) =>
      navigateTo(context, const StartScreen());

  void goToHome(BuildContext context) =>
      navigateTo(context, const HomeScreen());

  void goToMedia(BuildContext context) =>
      navigateTo(context, const MediaScreen());

  void goToMap(BuildContext context) =>
      navigateTo(context, const MapScreen());

  void goToForecast(BuildContext context) =>
      navigateTo(context, const ForecastScreen());

  void goToSettings(BuildContext context) =>
      navigateTo(context, const SettingsScreen());
}