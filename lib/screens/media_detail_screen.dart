// screens/media_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/media_item.dart';
import '../utility/theme.dart';

// Opened when any media card or search preview is tapped
class MediaDetailScreen extends StatelessWidget {
  final MediaItem item;

  const MediaDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full thumbnail display
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  item.thumbnailUrl.isNotEmpty
                      ? Image.network(
                          item.thumbnailUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 200,
                            color: AppTheme.marsGrey,
                          ),
                        )
                      : Container(height: 200, color: AppTheme.marsGrey),

                  // Video indicator overlay
                  if (item.mediaType == 'video')
                    const Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 64,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Media title
            Text(
              item.title,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 8),

            // Date
            Text(
              item.dateCreated.length >= 10
                  ? item.dateCreated.substring(0, 10) // Show YYYY-MM-DD only
                  : item.dateCreated,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),

            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),

            // Full description
            Text(
              item.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}