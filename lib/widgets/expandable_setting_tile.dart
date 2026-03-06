// widgets/expandable_setting_tile.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';

class ExpandableSettingTile extends StatelessWidget {
  final String title;           // Section title
  final String content;         // Section content
  final bool isExpanded;        // Current expansion state
  final VoidCallback onTap;     // Callback when tapped

  const ExpandableSettingTile({
    super.key,
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Header (always visible, tappable) ──
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.marsGrey,
              border: Border.all(
                color: isExpanded ? AppTheme.marsOrange : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.marsWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Chevron icon that rotates
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.expand_more,
                    color: AppTheme.marsOrange,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Content (shown/hidden based on isExpanded) ──
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: isExpanded
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.marsBlack,
                    border: Border(
                      left: BorderSide(
                        color: AppTheme.marsOrange,
                        width: 3,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    // Makes content scrollable if too long
                    child: Text(
                      content,
                      style: const TextStyle(
                        color: AppTheme.marsWhite,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(), // Collapses to nothing when not expanded
        ),

        // Spacing between tiles
        const SizedBox(height: 12),
      ],
    );
  }
}