// widgets/map_control_button.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';

// Reusable square icon button used for map controls: zoom in, zoom out, compass
// Separated from map_screen.dart because it is used 3 times and
// could be reused on other screens in future
class MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MapControlButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppTheme.marsBlack.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}