// models/saved_media_item.dart
class SavedMediaItem {
  final String nasaId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String mediaType;
  final String dateCreated;
  final String savedAt; // Timestamp of when the user saved this item

  SavedMediaItem({
    required this.nasaId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.mediaType,
    required this.dateCreated,
    required this.savedAt,
  });

  // Converts to Map so it can be written to the JSON file on device
  Map<String, dynamic> toJson() {
    return {
      'nasaId': nasaId,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'mediaType': mediaType,
      'dateCreated': dateCreated,
      'savedAt': savedAt,
    };
  }

  // Reconstructs a SavedMediaItem from a JSON map when loading from device
  factory SavedMediaItem.fromJson(Map<String, dynamic> json) {
    return SavedMediaItem(
      nasaId: json['nasaId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      mediaType: json['mediaType'] ?? 'image',
      dateCreated: json['dateCreated'] ?? '',
      savedAt: json['savedAt'] ?? '',
    );
  }
}