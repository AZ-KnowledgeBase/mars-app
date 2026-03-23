// screens/start_screen.dart
import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import '../utility/theme.dart';
import 'home_page.dart';

// Login and registration screen — entry point for unauthenticated users
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final AuthController _controller = AuthController();

  // Text controllers for input fields
  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // Tracks which form is showing — login or register
  bool _isLogin   = true;    // Toggles between login and register form
  bool _isLoading = false;   // Drives the loading spinner on the submit button
  String? _errorMessage;     // Displays Firebase auth error messages to the user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Welcome to Mars App' : 'Create Account'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Removes back arrow — this is the first screen
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        children: [

          // ── Background image fills the entire screen ──
          Positioned.fill(
            child: Image.asset(
              'assets/images/universe-background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ── Screen content sits on top of the background ──
          // ConstrainedBox ensures content fills full screen height, preventing a black gap at the bottom
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // App logo placeholder
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.marsGrey,
                      border: Border.all(
                        color: AppTheme.marsLightGrey,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: AppTheme.marsLightGrey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Username field — only shown on Register
                  if (!_isLogin) ...[
                    _buildTextField(
                      controller: _usernameController,
                      hint: 'Username',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Email field
                  _buildTextField(
                    controller: _emailController,
                    hint: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  _buildTextField(
                    controller: _passwordController,
                    hint: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),

                  const SizedBox(height: 12),

                  // Error message — only visible when auth fails
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                    ),

                  const SizedBox(height: 24),

                  // Login / Register button 
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.marsOrange,
                        foregroundColor: AppTheme.marsBlack,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: AppTheme.marsBlack)
                          : Text(
                              _isLogin ? 'Login' : 'Create Account',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Toggle between Login and Register
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                        _errorMessage = null; // Clear error when switching forms
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Don\'t have an account? Register'
                          : 'Already have an account? Login',
                      style: const TextStyle(color: AppTheme.marsOrange),
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

  // Delegates login or register to AuthController depending on current mode
  Future<void> _handleSubmit() async {
    setState(() {
      _isLoading    = true;
      _errorMessage = null;
    });

    String? error;

    if (_isLogin) {
      error = await _controller.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {
      error = await _controller.register(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );
    }

    setState(() => _isLoading = false);

    if (error != null) {
      setState(() => _errorMessage = error);
    } else {
      // Auth succeeded — navigate to home screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
  }

  // Reusable text field styled to match app theme
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIcon: Icon(icon, color: Colors.white38),
        filled: true,
        fillColor: AppTheme.marsGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Cleans up all text controllers from memory
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}