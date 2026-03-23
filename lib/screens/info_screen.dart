// screens/info_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/expandable_setting_tile.dart';
import '../controller/info_controller.dart';
import '../utility/theme.dart';

// Utility screen displaying app info, terms & conditions, and support via expandable tiles
class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // Controller instantiated in the View — logic fully delegated
  final InfoController _controller = InfoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [

          // Background image fills the entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/universe-background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ── Screen content sits on top of the background ──
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // ── Header Section ──
                const SizedBox(height: 16),
                const Text(
                  'More Info & Support',
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
                  // StatefulBuilder allows each tile to rebuild independently on tap
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
        ],
      ),
    );
  }
}