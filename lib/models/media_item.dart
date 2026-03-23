// models/media_item.dart

// Model representing a single media item returned from the NASA Image and Video Library API
class MediaItem {
  final String nasaId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String mediaType;   // 'image' or 'video'
  final String dateCreated;

  const MediaItem({
    required this.nasaId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.mediaType,
    required this.dateCreated,
  });

  // Parses a single item from the NASA API JSON response
  factory MediaItem.fromJson(Map<String, dynamic> item) {
    final data = item['data'][0];         // First data block holds metadata
    final links = item['links'] ?? [];    // Links block holds thumbnail URL

    return MediaItem(
      nasaId: data['nasa_id'] ?? '',
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? 'No description available.',
      thumbnailUrl: links.isNotEmpty ? links[0]['href'] ?? '' : '',
      mediaType: data['media_type'] ?? 'image',
      dateCreated: data['date_created'] ?? '',
    );
  }
}