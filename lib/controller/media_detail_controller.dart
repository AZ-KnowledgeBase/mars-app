// controller/media_detail_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/media_item.dart';
import '../models/saved_media_item.dart';
import '../controller/local_media_storage.dart';

// Handles save/remove/check logic and video URL fetching for the Media Detail Screen
class MediaDetailController {
  final LocalMediaStorage _storage = LocalMediaStorage();

  // Returns whether this item is already saved on the device
  Future<bool> isItemSaved(String nasaId) async {
    return await _storage.isItemSaved(nasaId);
  }

  // Converts a MediaItem to SavedMediaItem and saves it to the device
  Future<void> saveItem(MediaItem item) async {
    final saved = SavedMediaItem(
      nasaId: item.nasaId,
      title: item.title,
      description: item.description,
      thumbnailUrl: item.thumbnailUrl,
      mediaType: item.mediaType,
      dateCreated: item.dateCreated,
      savedAt: DateTime.now().toIso8601String(),
    );
    await _storage.saveItem(saved);
  }

  // Removes this item from local storage by its nasaId
  Future<void> removeItem(String nasaId) async {
    await _storage.removeItem(nasaId);
  }

  // Fetches the actual video URL for a given nasaId from the NASA API
  Future<String?> fetchVideoUrl(String nasaId) async {
    try {
      final uri = Uri.parse(
        'https://images-api.nasa.gov/asset/$nasaId',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final items = json['collection']['items'] as List;

        for (final item in items) {
          final href = item['href'] as String;
          if (href.endsWith('.mp4')) {
            // Force https — Android blocks http video streams by default
          return href.replaceFirst('http://', 'https://');
        }
      }
    }
    return null;
    } catch (e) {
      return null;
    }
  }
}