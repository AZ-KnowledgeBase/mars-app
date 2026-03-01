// screens/forecast_screen.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top bar
      appBar: AppBar(
        title: const Text('Forecast'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(), // Drawer menu
      body: const SizedBox(), // Empty body
    );
  }
}