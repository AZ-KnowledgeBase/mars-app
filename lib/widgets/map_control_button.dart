// widgets/map_control_button.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';

// Reusable square icon button for map controls — used for zoom in, zoom out, and compass reset
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
          border: Border.all(color: AppTheme.marsLightGrey),
        ),
        child: Icon(icon, color: AppTheme.marsWhite, size: 22),
      ),
    );
  }
}