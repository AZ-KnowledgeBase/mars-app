// widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';
import '../controller/drawer_controller.dart'; // Import controller

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller instantiated in the View, logic delegated to it
    final AppDrawerController controller = AppDrawerController();

    return Drawer(
      backgroundColor: AppTheme.marsBlack,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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

          // ✅ View only handles UI — taps delegate to controller
          ListTile(
            leading: const Icon(Icons.rocket_launch, color: Colors.white),
            title: const Text('Start', style: TextStyle(color: Colors.white)),
            onTap: () => controller.goToStart(context),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () => controller.goToHome(context),
          ),
          ListTile(
            leading: const Icon(Icons.perm_media, color: Colors.white),
            title: const Text('Media', style: TextStyle(color: Colors.white)),
            onTap: () => controller.goToMedia(context),
          ),
          ListTile(
            leading: const Icon(Icons.map, color: Colors.white),
            title: const Text('Map', style: TextStyle(color: Colors.white)),
            onTap: () => controller.goToMap(context),
          ),
          ListTile(
            leading: const Icon(Icons.cloud, color: Colors.white),
            title: const Text('Forecast', style: TextStyle(color: Colors.white)),
            onTap: () => controller.goToForecast(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () => controller.goToSettings(context),
          ),
        ],
      ),
    );
  }
}