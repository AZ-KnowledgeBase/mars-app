// controller/local_media_storage.dart
// Handles all reading and writing of saved media items to the device
// Sits in controller/ because it manages data logic used by other controllers
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/saved_media_item.dart';

class LocalMediaStorage {

  // Gets the device's local documents directory path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Points to the JSON file where all saved media items are stored
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/saved_media.json');
  }

  // Creates the JSON file with an empty list if it doesn't already exist
  Future<void> _initializeData() async {
    final file = await _localFile;
    if (!await file.exists()) {
      Map<String, dynamic> initialData = {'savedItems': []};
      await file.writeAsString(jsonEncode(initialData));
    }
  }

  // Saves a media item to the JSON file on the device
  // Checks for duplicates using nasaId before saving
  Future<void> saveItem(SavedMediaItem item) async {
    await _initializeData();
    final file = await _localFile;
    String content = await file.readAsString();
    Map<String, dynamic> jsonData = jsonDecode(content);

    List<dynamic> items = jsonData['savedItems'];

    // Prevent saving the same item twice
    final alreadySaved = items.any((i) => i['nasaId'] == item.nasaId);
    if (!alreadySaved) {
      items.add(item.toJson());
      await file.writeAsString(jsonEncode(jsonData));
    }
  }

  // Removes a saved item from the JSON file by its nasaId
  Future<void> removeItem(String nasaId) async {
    await _initializeData();
    final file = await _localFile;
    String content = await file.readAsString();
    Map<String, dynamic> jsonData = jsonDecode(content);

    List<dynamic> items = jsonData['savedItems'];
    items.removeWhere((i) => i['nasaId'] == nasaId);

    await file.writeAsString(jsonEncode(jsonData));
  }

  // Returns true if an item with the given nasaId is already saved
  Future<bool> isItemSaved(String nasaId) async {
    await _initializeData();
    final file = await _localFile;
    String content = await file.readAsString();
    Map<String, dynamic> jsonData = jsonDecode(content);
    List<dynamic> items = jsonData['savedItems'];
    return items.any((i) => i['nasaId'] == nasaId);
  }

  // Loads and returns all saved media items from the JSON file
  Future<List<SavedMediaItem>> loadSavedItems() async {
    await _initializeData();
    final file = await _localFile;
    String content = await file.readAsString();
    Map<String, dynamic> jsonData = jsonDecode(content);

    List<dynamic> items = jsonData['savedItems'];
    List<SavedMediaItem> savedItems = [];

    for (var item in items) {
      try {
        savedItems.add(SavedMediaItem.fromJson(item));
      } catch (e) {
        // Skip any malformed entries
      }
    }
    return savedItems;
  }
}