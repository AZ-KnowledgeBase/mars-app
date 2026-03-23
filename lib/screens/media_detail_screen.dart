// screens/media_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/media_item.dart';
import '../utility/theme.dart';
import '../controller/media_detail_controller.dart';

// Detail screen for a single media item — displays image or video, title, date, description, and save button
class MediaDetailScreen extends StatefulWidget {
  final MediaItem item;
  const MediaDetailScreen({super.key, required this.item});

  @override
  State<MediaDetailScreen> createState() => _MediaDetailScreenState();
}

class _MediaDetailScreenState extends State<MediaDetailScreen> {
  final MediaDetailController _controller = MediaDetailController();
  bool _isSaved = false;      // Whether this item is saved to the device
  bool _isSaveLoading = true; // Drives the bookmark loading state

  // Video player state
  VideoPlayerController? _videoController;
  bool _isVideoLoading = false;
  bool _isPlaying = false;
  String? _videoError; // Shown if video URL fetch fails

  @override
  void initState() {
    super.initState();
    // Check save state when screen opens
    _controller.isItemSaved(widget.item.nasaId).then((saved) {
      setState(() {
        _isSaved = saved;
        _isSaveLoading = false;
      });
    });

    // Fetch and initialize video if this is a video item
    if (widget.item.mediaType == 'video') {
      _initializeVideo();
    }
  }

  // Fetches the video URL and sets up the VideoPlayerController
  Future<void> _initializeVideo() async {
    setState(() => _isVideoLoading = true);

    final videoUrl = await _controller.fetchVideoUrl(widget.item.nasaId);

    if (videoUrl == null) {
      setState(() {
        _videoError = 'Video unavailable for this item.';
        _isVideoLoading = false;
      });
      return;
    }

    // Initialize the video player with the fetched URL
    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() => _isVideoLoading = false);
      }).catchError((_) {
        setState(() {
          _videoError = 'Failed to load video.';
          _isVideoLoading = false;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // Bookmark icon in app bar
          _isSaveLoading
              ? const Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : IconButton(
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: _isSaved ? AppTheme.marsOrange : Colors.white,
                  ),
                  onPressed: _handleSaveToggle,
                ),
        ],
      ),
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Media display — video player or image depending on type ──
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.item.mediaType == 'video'
                      ? _buildVideoPlayer()
                      : _buildImage(),
                ),

                const SizedBox(height: 16),

                // Media title
                Text(
                  widget.item.title,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 8),

                // Creation date trimmed to YYYY-MM-DD
                Text(
                  widget.item.dateCreated.length >= 10
                      ? widget.item.dateCreated.substring(0, 10)
                      : widget.item.dateCreated,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),

                const SizedBox(height: 12),

                // Full width save/unsave button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSaveLoading ? null : _handleSaveToggle,
                    icon: Icon(
                      _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    label: Text(_isSaved ? 'Saved' : 'Save to Device'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isSaved ? AppTheme.marsGrey : AppTheme.marsOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(color: Colors.white24),
                const SizedBox(height: 8),

                // Full description
                Text(
                  widget.item.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Builds the video player widget with play/pause controls
  Widget _buildVideoPlayer() {
    // Show error message if video failed to load
    if (_videoError != null) {
      return Container(
        height: 200,
        color: AppTheme.marsGrey,
        child: Center(
          child: Text(
            _videoError!,
            style: const TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    // Show loading spinner while video initializes
    if (_isVideoLoading || _videoController == null || !_videoController!.value.isInitialized) {
      return Container(
        height: 200,
        color: AppTheme.marsGrey,
        child: const Center(
          child: CircularProgressIndicator(color: AppTheme.marsOrange),
        ),
      );
    }

    // Show the actual video player once initialized
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
        // Play/pause button overlay
        GestureDetector(
          onTap: _togglePlayPause,
          child: Container(
            color: Colors.transparent,
            child: Icon(
              _isPlaying ? Icons.pause_circle : Icons.play_circle,
              color: Colors.white,
              size: 64,
            ),
          ),
        ),
      ],
    );
  }

  // Builds the static image for non-video items
  Widget _buildImage() {
    return widget.item.thumbnailUrl.isNotEmpty
        ? Image.network(
            widget.item.thumbnailUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(height: 200, color: AppTheme.marsGrey),
          )
        : Container(height: 200, color: AppTheme.marsGrey);
  }

  // Toggles video play and pause state
  void _togglePlayPause() {
    if (_videoController == null) return;
    setState(() {
      if (_isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  // Toggles save state — delegates all logic to the controller
  Future<void> _handleSaveToggle() async {
    setState(() => _isSaveLoading = true);

    if (_isSaved) {
      await _controller.removeItem(widget.item.nasaId);
    } else {
      await _controller.saveItem(widget.item);
    }

    setState(() {
      _isSaved = !_isSaved;
      _isSaveLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isSaved ? 'Saved to device' : 'Removed from saved'),
          backgroundColor: AppTheme.marsGrey,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Release video player resources when screen closes
    _videoController?.dispose();
    super.dispose();
  }
}