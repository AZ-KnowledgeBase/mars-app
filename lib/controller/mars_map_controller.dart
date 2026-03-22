// controller/mars_map_controller.dart
// Named MarsMapController to avoid conflict with flutter_map's built-in MapController
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:webview_flutter/webview_flutter.dart';
import '../models/map_state.dart';

class MarsMapController {
  final MapState state = MapState();

  // flutter_map's built-in controller — handles 2D pan and zoom programmatically
  final MapController flutterMapController = MapController();

  // Set when 3D view initializes — used to call JS zoom/reset functions
  WebViewController? webViewController;

  static const LatLng _defaultCenter = LatLng(0, 0);

  // Switches between 2D and 3D mode
  void toggle3D(void Function() refresh) {
    state.is3D = !state.is3D;
    refresh();
  }

  void zoomIn(void Function() refresh) {
    if (state.is3D) {
      // Calls the zoomIn() function defined in the Three.js globe HTML
      webViewController?.runJavaScript('zoomIn()');
    } else {
      state.zoomLevel = (state.zoomLevel + 1).clamp(MapState.minZoom, MapState.maxZoom);
      flutterMapController.move(flutterMapController.camera.center, state.zoomLevel);
      refresh();
    }
  }

  void zoomOut(void Function() refresh) {
    if (state.is3D) {
      // Calls the zoomOut() function defined in the Three.js globe HTML
      webViewController?.runJavaScript('zoomOut()');
    } else {
      state.zoomLevel = (state.zoomLevel - 1).clamp(MapState.minZoom, MapState.maxZoom);
      flutterMapController.move(flutterMapController.camera.center, state.zoomLevel);
      refresh();
    }
  }

  // Resets map to default position and orientation
  void resetCompass(void Function() refresh) {
    if (state.is3D) {
      // Calls the resetView() function defined in the Three.js globe HTML
      webViewController?.runJavaScript('resetView()');
    } else {
      // Moves back to center, resets zoom and rotation to 0 (north-up)
      flutterMapController.moveAndRotate(_defaultCenter, MapState.defaultZoom, 0);
      state.zoomLevel = MapState.defaultZoom;
      refresh();
    }
  }
}