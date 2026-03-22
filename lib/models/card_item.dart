// models/card_item.dart
import 'package:flutter/material.dart';

// Represents the data for a single selection card on the Home Screen
class CardItem {
  final String label; // Display name of card
  final Widget destination; // Destination screen when tapped
  final String imagePath; // Path to the card's background image
  bool isSelected;  // Track whether card is tapped

  CardItem({
    required this.label, 
    required this.destination,
    required this.imagePath,
    this.isSelected = false, 
  });
}