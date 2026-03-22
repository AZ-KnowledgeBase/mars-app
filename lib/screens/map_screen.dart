// screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/app_drawer.dart';
import '../widgets/map_control_button.dart'; 
import '../widgets/map_3d_toggle.dart';       
import '../utility/theme.dart';
import '../controller/mars_map_controller.dart';
import '../models/map_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MarsMapController _controller = MarsMapController();

  // Tracks whether the 3D WebView is still loading — drives the loading overlay
  bool _is3DLoading = false;

  // NASA Mars Viking Color Mosaic WMTS tile URL
  static const String _marsWmtsUrl =
      'https://api.nasa.gov/mars-wmts/catalog/Mars_Viking_MDIM21_ClrMosaic_global_232m/1.0.0/default/default028mm/{z}/{y}/{x}.jpg';

  // Self-contained Three.js HTML for the 3D globe loaded into the WebView
  static const String _globe3DHTML = '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <style>
    * { margin: 0; padding: 0; }
    body { background: #1b1b1b; overflow: hidden; width: 100vw; height: 100vh; }
    #loading {
      position: absolute; top: 50%; left: 50%;
      transform: translate(-50%, -50%);
      color: #FF8000; font-family: sans-serif; font-size: 16px;
    }
  </style>
</head>
<body>
  <div id="loading">Loading Mars...</div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
  <script>
    const scene  = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(45, window.innerWidth/window.innerHeight, 0.1, 100);
    camera.position.z = 3;

    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio || 1);
    document.body.appendChild(renderer.domElement);

    // Starfield background
    const starVerts = [];
    for (let i = 0; i < 2000; i++) {
      starVerts.push((Math.random()-0.5)*200, (Math.random()-0.5)*200, (Math.random()-0.5)*200);
    }
    const starGeo = new THREE.BufferGeometry();
    starGeo.setAttribute('position', new THREE.Float32BufferAttribute(starVerts, 3));
    scene.add(new THREE.Points(starGeo, new THREE.PointsMaterial({ color: 0xffffff, size: 0.1 })));

    // Mars sphere — starts with orange fallback colour, texture applied on load
    const material = new THREE.MeshBasicMaterial({ color: 0xc1440e });
    const mars = new THREE.Mesh(new THREE.SphereGeometry(1, 64, 64), material);
    scene.add(mars);

    // Load the zoom-0 WMTS overview tile as the globe texture
    new THREE.TextureLoader().load(
      'https://raw.githubusercontent.com/Krimit/mars/master/mars.jpg',
      (tex) => {
        material.map = tex;
        material.color.set(0xffffff);
        material.needsUpdate = true;
        document.getElementById('loading').style.display = 'none';
      },
      undefined,
      () => { document.getElementById('loading').style.display = 'none'; }
    );

    // Touch state for rotation and pinch-zoom
    let lastTouch = null, lastPinch = null;

    renderer.domElement.addEventListener('touchstart', (e) => {
      e.preventDefault();
      if (e.touches.length === 1) lastTouch = { x: e.touches[0].clientX, y: e.touches[0].clientY };
      if (e.touches.length === 2) lastPinch = Math.hypot(e.touches[0].clientX-e.touches[1].clientX, e.touches[0].clientY-e.touches[1].clientY);
    }, { passive: false });

    renderer.domElement.addEventListener('touchmove', (e) => {
      e.preventDefault();
      if (e.touches.length === 1 && lastTouch) {
        const dx = e.touches[0].clientX - lastTouch.x;
        const dy = e.touches[0].clientY - lastTouch.y;
        mars.rotation.y += dx * 0.004;
        // Clamp vertical rotation so globe cannot flip upside down
        mars.rotation.x = Math.max(-1.5, Math.min(1.5, mars.rotation.x + dy * 0.004));
        lastTouch = { x: e.touches[0].clientX, y: e.touches[0].clientY };
      }
      if (e.touches.length === 2) {
        const d = Math.hypot(e.touches[0].clientX-e.touches[1].clientX, e.touches[0].clientY-e.touches[1].clientY);
        if (lastPinch) camera.position.z = Math.max(1.5, Math.min(8, camera.position.z + (lastPinch-d)*0.02));
        lastPinch = d;
      }
    }, { passive: false });

    renderer.domElement.addEventListener('touchend', () => { lastTouch = null; lastPinch = null; });

    // Global functions called directly by Flutter via runJavaScript()
    function zoomIn()    { camera.position.z = Math.max(1.5, camera.position.z - 0.5); }
    function zoomOut()   { camera.position.z = Math.min(8,   camera.position.z + 0.5); }
    function resetView() { mars.rotation.set(0, 0, 0); camera.position.z = 3; }

    function animate() { requestAnimationFrame(animate); renderer.render(scene, camera); }
    animate();

    window.addEventListener('resize', () => {
      camera.aspect = window.innerWidth / window.innerHeight;
      camera.updateProjectionMatrix();
      renderer.setSize(window.innerWidth, window.innerHeight);
    });
  </script>
</body>
</html>
''';

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
          // ── Main map content — switches between 2D tiles and 3D globe ──
          _controller.state.is3D ? _build3DGlobe() : _build2DMap(),

          // ── Loading overlay when switching to 3D ──
          // Reuses same CircularProgressIndicator pattern as media_screen
          if (_is3DLoading)
            Container(
              color: AppTheme.marsBlack,
              child: const Center(
                child: CircularProgressIndicator(color: AppTheme.marsOrange),
              ),
            ),

          // ── Left side control buttons using separated MapControlButton widget ──
          Positioned(
            left: 16,
            top: 24,
            child: Column(
              children: [
                MapControlButton(
                  icon: Icons.add,
                  onTap: () => _controller.zoomIn(() => setState(() {})),
                ),
                const SizedBox(height: 8),
                MapControlButton(
                  icon: Icons.remove,
                  onTap: () => _controller.zoomOut(() => setState(() {})),
                ),
                const SizedBox(height: 8),
                // Compass — resets orientation in 2D, resets globe rotation in 3D
                MapControlButton(
                  icon: Icons.explore,
                  onTap: () => _controller.resetCompass(() => setState(() {})),
                ),
              ],
            ),
          ),

          // ── 3D toggle anchored to bottom center using separated Map3DToggle widget ──
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Map3DToggle(
                is3D: _controller.state.is3D,    // Passes current state from Model
                onToggle: _onToggle3D,            // Delegates action back to screen
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the 2D flat tile map using NASA Mars WMTS tiles
  Widget _build2DMap() {
    return FlutterMap(
      mapController: _controller.flutterMapController,
      options: MapOptions(
        initialCenter: const LatLng(0, 0),
        initialZoom: MapState.defaultZoom,
        minZoom: MapState.minZoom,
        maxZoom: MapState.maxZoom,
        backgroundColor: AppTheme.marsBlack, // Fills empty tile areas with Mars black
        // Pan and pinch-zoom only — rotation disabled in 2D mode
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        // Keeps state zoom level in sync when user gestures on the map
        onPositionChanged: (MapPosition position, bool hasGesture) {
          if (hasGesture && position.zoom != null) {
            setState(() => _controller.state.zoomLevel = position.zoom!);
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: _marsWmtsUrl,
          userAgentPackageName: 'com.example.mars_explorer_app',
        ),
      ],
    );
  }

  // Builds the 3D globe inside a WebView — null checked before use
  Widget _build3DGlobe() {
    if (_controller.webViewController == null) return const SizedBox.shrink();
    return WebViewWidget(controller: _controller.webViewController!);
  }

  // Handles 3D toggle — initializes WebView on first switch to 3D
  void _onToggle3D() {
    if (!_controller.state.is3D) {
      // Show loading overlay while the WebView and Three.js load
      setState(() => _is3DLoading = true);

      final wvc = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            // Hide loading overlay once the Three.js page has fully loaded
            onPageFinished: (_) => setState(() => _is3DLoading = false),
          ),
        )
        ..loadHtmlString(_globe3DHTML);

      // Pass to controller so zoom/reset buttons can call JS functions
      _controller.webViewController = wvc;
    }

    _controller.toggle3D(() => setState(() {}));
  }
}