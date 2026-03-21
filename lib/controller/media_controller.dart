// controller/media_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/media_item.dart';
import '../screens/media_detail_screen.dart';

class MediaController {
  static const String _baseUrl = 'https://images-api.nasa.gov/search';

  // Holds the full gallery of results
  List<MediaItem> galleryItems = [];

  // Default gallery loaded on screen init
  Future<List<MediaItem>> loadDefaultGallery() async {
    return await _fetchMedia('mars', pageSize: 20);
  }

  // Called when user taps the Search button
  Future<void> onSearchSubmitted(
    String query,
    void Function() refresh,
  ) async {
    if (query.trim().isEmpty) return;

    final results = await _fetchMedia(query, pageSize: 20);
    galleryItems = results;
    refresh(); // Triggers setState in the View
  }

  // Navigates to the detail screen when a gallery card is tapped
  void onMediaTapped(BuildContext context, MediaItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaDetailScreen(item: item),
      ),
    );
  }

  // Core API call
  Future<List<MediaItem>> _fetchMedia(String query, {int pageSize = 20}) async {
    final uri = Uri.parse(
      '$_baseUrl?q=$query&media_type=image,video&page_size=$pageSize',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final items = json['collection']['items'] as List;

        // Filter out items missing links (no thumbnail available)
        return items
            .where((item) => item['links'] != null)
            .map((item) => MediaItem.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}