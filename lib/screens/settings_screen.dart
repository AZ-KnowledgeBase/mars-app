// screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/expandable_setting_tile.dart';
import '../controller/settings_controller.dart';
import '../utility/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Controller instantiated in the View — logic fully delegated
  final SettingsController _controller = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── App Bar ──
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),

      // ── Body ──
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ── Header Section ──
            const SizedBox(height: 16),
            const Text(
              'Options',
              style: TextStyle(
                color: AppTheme.marsWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(color: AppTheme.marsGrey),
            const SizedBox(height: 16),

            // ── Expandable Settings List ──
            Expanded(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return ListView.builder(
                    itemCount: _controller.settingItems.length,
                    itemBuilder: (context, index) {
                      final item = _controller.settingItems[index];

                      return ExpandableSettingTile(
                        title: item.title,
                        content: item.content,
                        isExpanded: item.isExpanded,
                        // Toggle expansion and refresh UI
                        onTap: () {
                          _controller.toggleExpanded(index);
                          setState(() {}); // Triggers rebuild
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}