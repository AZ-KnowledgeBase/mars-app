// controller/home_controller.dart
import 'package:flutter/material.dart';
import '../models/card_item.dart';
import '../screens/media_screen.dart';
import '../screens/forecast_screen.dart';
import '../screens/map_screen.dart';
import '../screens/settings_screen.dart';

class HomeController {
  // Card definitions — all screen knowledge lives here, not in the View
  final List<CardItem> cards = [
    CardItem(label: 'Mars Gallery',  destination: const MediaScreen()),
    CardItem(label: 'Mars Forecast', destination: const ForecastScreen()),
    CardItem(label: 'Mars Map',      destination: const MapScreen()),
  ];

  // Handles card selection: deselects all others, selects tapped card, navigates
  void onCardTapped(BuildContext context, int index, void Function() refresh) {
    for (int i = 0; i < cards.length; i++) {
      cards[i].isSelected = (i == index); // Set selected true if condition is true
    }
    refresh(); // Triggers setState in the View so colour changes appear on screen
    
    //Navigates to destination screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => cards[index].destination),
    );
  }

  // Settings button navigation — separate from card logic
  void goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }
}