// widgets/map_3d_toggle.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';

// Toggle switch anchored to the bottom of the map screen for switching between 2D and 3D view
class Map3DToggle extends StatelessWidget {
  final bool is3D;             // Current toggle state read from MapState via map_screen
  final VoidCallback onToggle; // Delegates toggle action back up to map_screen

  const Map3DToggle({
    super.key,
    required this.is3D,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.marsBlack.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '3D View',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Switch(
            value: is3D,
            activeThumbColor: AppTheme.marsOrange, // Matches app theme on active state
            onChanged: (_) => onToggle(),            // Delegates to map_screen, no logic here
          ),
        ],
      ),
    );
  }
}