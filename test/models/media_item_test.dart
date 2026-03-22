import 'package:flutter_test/flutter_test.dart';
import 'package:mars_explorer_app/models/media_item.dart';

void main() {
  group('MediaItem.fromJson()', () {

    // A minimal valid JSON structure matching what NASA API returns
    final validJson = {
      'data': [
        {
          'nasa_id': 'PIA12345',
          'title': 'Mars Surface',
          'description': 'A photo of Mars.',
          'media_type': 'image',
          'date_created': '2023-01-15T00:00:00Z',
        }
      ],
      'links': [
        {'href': 'https://images.nasa.gov/thumb.jpg'}
      ],
    };

    test('parses nasaId correctly', () {
      final item = MediaItem.fromJson(validJson);
      expect(item.nasaId, 'PIA12345');
    });

    test('parses title correctly', () {
      final item = MediaItem.fromJson(validJson);
      expect(item.title, 'Mars Surface');
    });

    test('parses thumbnailUrl from links correctly', () {
      final item = MediaItem.fromJson(validJson);
      expect(item.thumbnailUrl, 'https://images.nasa.gov/thumb.jpg');
    });

    test('parses mediaType correctly', () {
      final item = MediaItem.fromJson(validJson);
      expect(item.mediaType, 'image');
    });

    test('uses default title when title is missing', () {
      final json = {
        'data': [
          {
            'nasa_id': 'PIA12345',
            'media_type': 'image',
            'date_created': '2023-01-15T00:00:00Z',
          }
        ],
        'links': [],
      };
      final item = MediaItem.fromJson(json);
      expect(item.title, 'No Title');
    });

    test('returns empty thumbnailUrl when links is empty', () {
      final json = {
        'data': [
          {
            'nasa_id': 'PIA12345',
            'title': 'Mars',
            'media_type': 'image',
            'date_created': '2023-01-15T00:00:00Z',
          }
        ],
        'links': [],
      };
      final item = MediaItem.fromJson(json);
      expect(item.thumbnailUrl, '');
    });

  });
}