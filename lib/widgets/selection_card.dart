// widgets/selection_card.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';

// View helper — paints a single card based on values received
// Intentionally has no Model knowledge, keeping it generic and reusable
class SelectionCard extends StatelessWidget {  
   // Received from CardItem via home_page
  final String label;
  final bool isSelected;
  // Delegated to home_controller
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    // Must be provided — card cannot render without these                                  
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100000), // Smooth transition when isSelected changes
        height: 180,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.marsRed : AppTheme.marsGrey, // Selected state drives color
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.marsOrange : Colors.transparent, // Orange border when selected
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Label bar — positioned at bottom of card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.marsOrange : AppTheme.marsBlack, // Label bar reacts to selection too
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                label, // Displays the value passed in from CardItem
                 style: AppTheme.cardLabelStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}