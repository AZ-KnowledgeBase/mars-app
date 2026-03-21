// controller/map_controller.dart
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/map_layer.dart';

class MapScreenController {
  // NASA Mars Trek WMTS base URL
  static const String _baseUrl =
      'https://api.nasa.gov/mars-wmts/catalog';

  // 2D layer — THEMIS IR Day mosaic (standard surface view)
  static const MapLayer layer2D = MapLayer(
    name: '2D',
    tileUrl:
        '$_baseUrl/Mars_Viking_MDIM21_ClrMosaic_global_232m/1.0.0/default/default028mm/{z}/{y}/{x}.jpg',
    is3D: false,
  );

  // 3D layer — MOLA colorized elevation (topographic/terrain view)
  static const MapLayer layer3D = MapLayer(
    name: '3D',
    tileUrl:
        '$_baseUrl/Mars_MO_THEMIS-IR-Day_mosaic_global_100m_v12_clon0_ly/1.0.0/default/default028mm/{z}/{y}/{x}.jpg',
    is3D: true,
  );

  // Default map center — Olympus Mons, Mars
  static final LatLng defaultCenter = LatLng(18.65, -133.8);
  static const double defaultZoom = 3.0;
  static const double minZoom = 1.0;
  static const double maxZoom = 8.0;

  // flutter_map controller — handles zoom and movement programmatically
  final MapController mapController = MapController();

  // Tracks which layer is currently active
  MapLayer activeLayer = layer2D;

  // Zooms in by 1 level, capped at maxZoom
  void zoomIn(double currentZoom) {
    final newZoom = (currentZoom + 1).clamp(minZoom, maxZoom);
    mapController.move(mapController.camera.center, newZoom);
  }

  // Zooms out by 1 level, capped at minZoom
  void zoomOut(double currentZoom) {
    final newZoom = (currentZoom - 1).clamp(minZoom, maxZoom);
    mapController.move(mapController.camera.center, newZoom);
  }

  // Resets map back to default center and zoom — compass reset
  void resetCompass() {
    mapController.moveAndRotate(defaultCenter, defaultZoom, 0);
  }

  // Toggles between 2D and 3D layer, triggers UI refresh via callback
  void toggle3D(void Function() refresh) {
    activeLayer = activeLayer.is3D ? layer2D : layer3D;
    refresh();
  }
}