// models/map_layer.dart

// Represents a single Mars Trek WMTS map layer
class MapLayer {
  final String name;
  final String tileUrl; // NASA WMTS tile endpoint for this layer
  final bool is3D;      // Whether this layer represents the 3D elevation view

  const MapLayer({
    required this.name,
    required this.tileUrl,
    required this.is3D,
  });
}