// widgets/map_controls.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';

// Reusable square icon button used for all map controls
class MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const MapControlButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppTheme.marsGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}