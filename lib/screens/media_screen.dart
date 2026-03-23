// screens/media_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/media_card.dart';
import '../utility/theme.dart';
import '../controller/media_controller.dart';

// Search and gallery screen for NASA images and videos
class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  final MediaController _controller = MediaController();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true; // Drives the loading spinner while the default gallery fetches

  @override
  void initState() {
    super.initState();
    // Load default Mars gallery when screen first opens
    _controller.loadDefaultGallery().then((items) {
      setState(() {
        _controller.galleryItems = items;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image & Video Search'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [

          // ── Background image fills the entire screen ──
          Positioned.fill(
            child: Image.asset(
              'assets/images/universe-background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ── Screen content sits on top of the background ──
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // ── Search Bar ──
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: AppTheme.marsWhite),
                  decoration: InputDecoration(
                    hintText: 'Enter Search...',
                    hintStyle: const TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: AppTheme.marsGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // ── Search Button ──
                ElevatedButton(
                  onPressed: () => _controller.onSearchSubmitted(
                    _searchController.text,
                    () => setState(() {}),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.marsBlack,
                    foregroundColor: AppTheme.marsWhite,
                    side: const BorderSide(color: AppTheme.marsLightGrey),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Search'),
                ),

                const SizedBox(height: 16),

                // ── Divider separating search from gallery ──
                const Divider(color: AppTheme.marsLightGrey, thickness: 1),

                const SizedBox(height: 12),

                // ── Gallery Label ──
                Text(
                  'Gallery',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 8),

                // ── Gallery Grid ──
                Expanded(
                  child: _isLoading
                      // Loading spinner while default gallery fetches
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.marsOrange,
                          ),
                        )
                      : _controller.galleryItems.isEmpty
                          // Empty state when no results found
                          ? const Center(
                              child: Text(
                                'No results found.',
                                style: TextStyle(color: Colors.white54),
                              ),
                            )
                          // 2 column grid matching the wireframe layout
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.85,
                              ),
                              itemCount: _controller.galleryItems.length,
                              itemBuilder: (context, index) {
                                final item = _controller.galleryItems[index];
                                return MediaCard(
                                  item: item,
                                  // Delegates navigation to the Controller
                                  onTap: () =>
                                      _controller.onMediaTapped(context, item),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Cleans up text controller from memory
    super.dispose();
  }
}