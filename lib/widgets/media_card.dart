// widgets/media_card.dart
import 'package:flutter/material.dart';
import '../models/media_item.dart';
import '../utility/theme.dart';

// Displays a single media item in the gallery grid
class MediaCard extends StatelessWidget {
  final MediaItem item;
  final VoidCallback onTap;

  const MediaCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.marsGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Thumbnail image area
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Loads thumbnail from NASA API
                    item.thumbnailUrl.isNotEmpty
                        ? Image.network(
                            item.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: AppTheme.marsGrey,
                            ),
                          )
                        : Container(color: AppTheme.marsGrey),

                    // Video overlay icon so user knows it's a video
                    if (item.mediaType == 'video')
                      const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Title label at bottom of card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: const BoxDecoration(
                color: AppTheme.marsBlack,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                item.title,
                style: AppTheme.cardLabelStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Truncates long titles cleanly
              ),
            ),
          ],
        ),
      ),
    );
  }
}