import 'package:flutter_test/flutter_test.dart';
import 'package:mars_explorer_app/models/map_state.dart';

void main() {
  group('MapState', () {

    test('starts in 2D mode by default', () {
      final state = MapState();
      expect(state.is3D, false);
    });

    test('starts at default zoom level', () {
      final state = MapState();
      expect(state.zoomLevel, MapState.defaultZoom);
    });

    test('defaultZoom is within min and max boundaries', () {
      expect(MapState.defaultZoom >= MapState.minZoom, true);
      expect(MapState.defaultZoom <= MapState.maxZoom, true);
    });

    test('minZoom is less than maxZoom', () {
      expect(MapState.minZoom < MapState.maxZoom, true);
    });

    test('is3D can be toggled to true', () {
      final state = MapState();
      state.is3D = true;
      expect(state.is3D, true);
    });

    test('zoomLevel can be updated', () {
      final state = MapState();
      state.zoomLevel = 5.0;
      expect(state.zoomLevel, 5.0);
    });

  });
}