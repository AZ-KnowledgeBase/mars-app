import 'package:flutter_test/flutter_test.dart';
import 'package:mars_explorer_app/models/saved_media_item.dart';

void main() {
  group('SavedMediaItem', () {

    final testItem = SavedMediaItem(
      nasaId: 'PIA12345',
      title: 'Mars Surface',
      description: 'A photo of Mars.',
      thumbnailUrl: 'https://images.nasa.gov/thumb.jpg',
      mediaType: 'image',
      dateCreated: '2023-01-15',
      savedAt: '2026-03-22T10:00:00.000',
    );

    group('toJson()', () {

      test('returns map with all 7 keys', () {
        expect(testItem.toJson().length, 7);
      });

      test('nasaId is correctly serialized', () {
        expect(testItem.toJson()['nasaId'], 'PIA12345');
      });

      test('savedAt is correctly serialized', () {
        expect(testItem.toJson()['savedAt'], '2026-03-22T10:00:00.000');
      });

    });

    group('fromJson()', () {

      test('reconstructs item correctly from map', () {
        final json = testItem.toJson();
        final reconstructed = SavedMediaItem.fromJson(json);

        expect(reconstructed.nasaId, testItem.nasaId);
        expect(reconstructed.title, testItem.title);
        expect(reconstructed.mediaType, testItem.mediaType);
        expect(reconstructed.savedAt, testItem.savedAt);
      });

      test('uses default mediaType when missing from json', () {
        final json = {
          'nasaId': 'PIA12345',
          'title': 'Mars',
          'description': '',
          'thumbnailUrl': '',
          'dateCreated': '',
          'savedAt': '',
          // mediaType intentionally omitted
        };
        final item = SavedMediaItem.fromJson(json);
        expect(item.mediaType, 'image'); // Default value
      });

      test('handles empty strings gracefully', () {
        final json = {
          'nasaId': '',
          'title': '',
          'description': '',
          'thumbnailUrl': '',
          'mediaType': '',
          'dateCreated': '',
          'savedAt': '',
        };
        final item = SavedMediaItem.fromJson(json);
        expect(item.nasaId, '');
        expect(item.title, '');
      });

    });

  });
}