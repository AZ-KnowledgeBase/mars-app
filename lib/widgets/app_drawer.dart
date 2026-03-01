// widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';
import '../screens/start_screen.dart';
import '../screens/home_page.dart';
import '../screens/media_screen.dart';
import '../screens/map_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/forecast_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.marsBlack,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.public, size: 48, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  'Mars Explorer',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          
          // Menu items: 
          // Start Screen Icon
          ListTile(
            leading: const Icon(Icons.rocket_launch, color: Colors.white),
            title: const Text('Start', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const StartScreen()),
              );
            },
          ),

          // Homepage Icon
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),

          // Media Screen Icon
          ListTile(
            leading: const Icon(Icons.perm_media, color: Colors.white),
            title: const Text('Media', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MediaScreen()),
              );
            },
          ),

          // Map Screen Icon
          ListTile(
            leading: const Icon(Icons.map, color: Colors.white),
            title: const Text('Map', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MapScreen()),
              );
            },
          ),

          // Forecast Screen Icon
          ListTile(
            leading: const Icon(Icons.cloud, color: Colors.white),
            title: const Text('Forecast', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ForecastScreen()),
              );
            },
          ),

          // Settings Screen Icon
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}