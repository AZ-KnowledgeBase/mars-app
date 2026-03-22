// screens/saved_media_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/media_card.dart';
import '../utility/theme.dart';
import '../controller/local_media_storage.dart';
import '../models/saved_media_item.dart';
import '../models/media_item.dart';
import 'media_detail_screen.dart';

class SavedMediaScreen extends StatefulWidget {
  const SavedMediaScreen({super.key});

  @override
  State<SavedMediaScreen> createState() => _SavedMediaScreenState();
}

class _SavedMediaScreenState extends State<SavedMediaScreen> {
  final LocalMediaStorage _storage = LocalMediaStorage();
  List<SavedMediaItem> _savedItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load all saved items from the device when the screen opens
    _storage.loadSavedItems().then((items) {
      setState(() {
        _savedItems = items;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Media'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Saved', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            const Divider(color: Colors.white24),
            const SizedBox(height: 12),

            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.marsOrange,
                      ),
                    )
                  : _savedItems.isEmpty
                      ? const Center(
                          child: Text(
                            'No saved items yet.\nTap the bookmark icon on any media to save it.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white54),
                          ),
                        )
                      // 2 column grid reusing the MediaCard widget
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: _savedItems.length,
                          itemBuilder: (context, index) {
                            final saved = _savedItems[index];

                            // Convert SavedMediaItem to MediaItem to reuse MediaCard
                            final mediaItem = MediaItem(
                              nasaId: saved.nasaId,
                              title: saved.title,
                              description: saved.description,
                              thumbnailUrl: saved.thumbnailUrl,
                              mediaType: saved.mediaType,
                              dateCreated: saved.dateCreated,
                            );

                            return MediaCard(
                              item: mediaItem,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MediaDetailScreen(item: mediaItem),
                                ),
                              ).then((_) {
                                // Refresh the list when returning from detail screen
                                // in case the user unsaved the item
                                _storage.loadSavedItems().then((items) {
                                  setState(() => _savedItems = items);
                                });
                              }),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}