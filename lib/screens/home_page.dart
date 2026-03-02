// screens/home_page.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/selection_card.dart';
import '../utility/theme.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller instantiated in the View — logic fully delegated
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds equal spacing of 16px around all card content
        child: Column(
          children: [
           const SizedBox(height: 55),
            // ── Top full-width card: Mars Gallery ──
            // Passes card data from the Model and delegates tap logic to the Controller
           SelectionCard(
              // Card label pulled from Model
              label: _controller.cards[0].label,           
              // Selection state from Model
              isSelected: _controller.cards[0].isSelected, 
              // Controller handles tap, setState triggers UI refresh
              onTap: () => _controller.onCardTapped(context, 0, () => setState(() {})), 
            ),

           // Adds space between the Top card and Bottom Cards
           const SizedBox(height: 16),

            // ── Bottom row: Mars Forecast + Mars Map ──
            Row(
              children: [
                Expanded(
                  child: SelectionCard(
                    label: _controller.cards[1].label,
                    isSelected: _controller.cards[1].isSelected,
                    onTap: () => _controller.onCardTapped(context, 1, () => setState(() {})),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SelectionCard(
                    label: _controller.cards[2].label,
                    isSelected: _controller.cards[2].isSelected,
                    onTap: () => _controller.onCardTapped(context, 2, () => setState(() {})),
                  ),
                ),
              ],
            ),

            // Pushes the settings button to the bottom of the screen
            const Spacer(),
            // Visual separator line between cards and settings button
            const Divider(color: AppTheme.marsWhite),
            // Small gap between divider and button
            const SizedBox(height: 8),

            // ── Settings button — independent of card logic ──
            Row(
              children: [
                // Placeholder icon slot
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.marsGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _controller.goToSettings(context),
                    // Styles the settings button to match the app theme
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.marsBlack,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Settings'),
                  ),
                ),
              ],
            ),
            // Bottom padding to lift content off screen edge
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}