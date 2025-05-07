import 'package:book_trail/book_operation.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/views/screens/_login.dart';
import 'package:book_trail/views/widgets/_animatedpulserectangle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyScreen extends StatefulWidget {
  final BookOperation bookOperation;
  const BodyScreen({super.key, required this.bookOperation});

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Create AnimationController to control the duration of the Animation (3 seconds for each phase)
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Create Animation for fading in from 0.0 (invisible) to 1.0 (visible)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the Animation: fade in, then fade out, then navigate to appropriate screen
    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        // Ensure navigation happens after the widget is fully built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          Navigator.pushReplacementNamed(
            context,
            userProvider.userId == null ? '/login' : '/main',
          );
        });
      });
    });
  }

  @override
  void dispose() {
    // Clean up resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation, // Bind the Animation to the image
              child: Image.asset(
                'images/logo.png',
                height: 250,
                width: 250,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                "BookTrail",
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedPulseRectangle(opacityAnimation: _fadeAnimation),
          ],
        ),
      ),
    );
  }
}