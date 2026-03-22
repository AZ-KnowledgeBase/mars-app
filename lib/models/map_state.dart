// models/map_state.dart

// Holds all map state data — zoom level and current view mode
class MapState {
  bool is3D;
  double zoomLevel;

  // Zoom boundaries and default referenced across controller and view
  static const double minZoom     = 1.0;
  static const double maxZoom     = 10.0;
  static const double defaultZoom = 3.0;

  MapState({
    this.is3D      = false,          // Starts in 2D mode
    this.zoomLevel = defaultZoom,
  });
}