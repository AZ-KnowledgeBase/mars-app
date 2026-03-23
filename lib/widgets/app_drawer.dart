// widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../utility/theme.dart';
import '../controller/drawer_controller.dart';

// Reusable navigation drawer present on all main screens
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller instantiated in the View — logic delegated to it
    final AppDrawerController controller = AppDrawerController();

    return Drawer(
      backgroundColor: AppTheme.marsBlack,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header with app branding
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.public, size: 48, color: AppTheme.marsWhite),
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

          // View only handles UI — taps delegate to controller
          ListTile(
            leading: const Icon(Icons.home, color: AppTheme.marsWhite),
            title: const Text('Home', style: TextStyle(color: AppTheme.marsWhite)),
            onTap: () => controller.goToHome(context),
          ),
          ListTile(
            leading: const Icon(Icons.perm_media, color: AppTheme.marsWhite),
            title: const Text('Media', style: TextStyle(color: AppTheme.marsWhite)),
            onTap: () => controller.goToMedia(context),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark, color: AppTheme.marsWhite),
            title: const Text('Saved', style: TextStyle(color: AppTheme.marsWhite)),
            onTap: () => controller.goToSaved(context),
          ),
          ListTile(
            leading: const Icon(Icons.map, color: AppTheme.marsWhite),
            title: const Text('Map', style: TextStyle(color: AppTheme.marsWhite)),
            onTap: () => controller.goToMap(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppTheme.marsWhite),
            title: const Text('Info', style: TextStyle(color: AppTheme.marsWhite)),
            onTap: () => controller.goToSettings(context),
          ),

          // Visually separates logout from the main navigation items
          const Divider(color: Colors.white24), // Separator before logout

          // Signs the user out and returns them to the Start Screen
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.marsOrange),
            title: const Text('Logout', style: TextStyle(color: AppTheme.marsOrange)),
            onTap: () => controller.logout(context),
          ),
        ],
      ),
    );
  }
}