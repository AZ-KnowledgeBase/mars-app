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
  final String imagePath; // Asset path for the card's background image

  const SelectionCard({
    super.key,
    // Must be provided — card cannot render without these                                  
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Smooth transition when isSelected changes
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.marsRed : AppTheme.marsGrey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.marsOrange : Colors.transparent, // Orange border when selected
            width: 2,
          ),
        ),
        // ClipRRect ensures the image respects the card's rounded corners
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image fills the entire card
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppTheme.marsGrey, // Fallback colour if image fails to load
                ),
              ),

              // Dark gradient overlay so the label text stays readable over the image
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.6), // Fades to dark at the bottom
                    ],
                  ),
                ),
              ),

              // Label bar anchored to the bottom of the card
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      // Label bar colour reacts to selection state
                      color: isSelected
                          ? AppTheme.marsOrange.withValues(alpha: 0.9)
                          : AppTheme.marsBlack.withValues(alpha: 0.75),
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
            ],
          ),
        ),
      ),
    );
  }
}