// screens/start_screen.dart
import 'package:flutter/material.dart';
import 'home_page.dart';
import '../utility/theme.dart';
import '../widgets/app_drawer.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top bar with title and menu
      appBar: AppBar(
        title: const Text('Welcome to the Mars App'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Hamburger icon is automatic when drawer exists
      ),
      drawer: const AppDrawer(), // Reusable drawer
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Mars image/logo
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: AppTheme.marsBlack,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 70), // Vertical spacing
            
            // Main navigation button
            ElevatedButton(
              onPressed: () {
                // Navigate to home screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.marsOrange,
                foregroundColor: AppTheme.marsBlack,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 25,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Start Exploring',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}