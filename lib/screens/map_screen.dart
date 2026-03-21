// screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../widgets/app_drawer.dart';
import '../widgets/map_controls.dart';
import '../utility/theme.dart';
import '../controller/map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Controller owns all map logic and state
  final MapScreenController _controller = MapScreenController();
  double _currentZoom = MapScreenController.defaultZoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mars Map'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [

          // ── Mars Map Tile Layer ──
          FlutterMap(
            mapController: _controller.mapController,
            options: MapOptions(
              initialCenter: MapScreenController.defaultCenter,
              initialZoom: MapScreenController.defaultZoom,
              minZoom: MapScreenController.minZoom,
              maxZoom: MapScreenController.maxZoom,
              // Tracks zoom level changes to keep state in sync
              onPositionChanged: (position, hasGesture) {
                setState(() {
                  _currentZoom = position.zoom!;
                });
              },
            ),
            children: [
              // Swaps tile URL when 3D toggle is pressed
              TileLayer(
                key: ValueKey(_controller.activeLayer.name), // Forces rebuild on layer switch
                urlTemplate: _controller.activeLayer.tileUrl,
                userAgentPackageName: 'com.example.mars_explorer_app',
                errorTileCallback: (tile, error, stackTrace) {},
              ),
            ],
          ),

          // ── Left Side Controls: Zoom + Compass ──
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              children: [
                // Zoom In
                MapControlButton(
                  icon: Icons.add,
                  onTap: () => setState(() {
                    _controller.zoomIn(_currentZoom);
                  }),
                ),
                const SizedBox(height: 8),

                // Zoom Out
                MapControlButton(
                  icon: Icons.remove,
                  onTap: () => setState(() {
                    _controller.zoomOut(_currentZoom);
                  }),
                ),
                const SizedBox(height: 8),

                // Compass — resets map orientation and position
                MapControlButton(
                  icon: Icons.explore,
                  onTap: () => setState(() {
                    _controller.resetCompass();
                    _currentZoom = MapScreenController.defaultZoom;
                  }),
                ),
              ],
            ),
          ),

          // ── Bottom Centre: 3D View Toggle ──
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  // Label above the toggle
                  Text(
                    '3D View',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(blurRadius: 4, color: Colors.black)
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Toggle switch — swaps between 2D and 3D layer
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.marsGrey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Switch(
                      value: _controller.activeLayer.is3D,
                      // Delegates toggle logic to controller
                      onChanged: (_) => _controller.toggle3D(
                        () => setState(() {}),
                      ),
                      activeThumbColor: AppTheme.marsOrange,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: AppTheme.marsBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}