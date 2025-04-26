import 'package:book_trail/views/_login.dart';
import 'package:book_trail/views/widgets/_animatedpulserectangle.dart';
import 'package:flutter/material.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({super.key});

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen>
    with SingleTickerProviderStateMixin {
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

    // Start the Animation: fade in, then fade out, then navigate to LoginScreen
    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        // Ensure navigation happens after the widget is fully built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
    return Center(
      child: Column(
        children: [
          FadeTransition(
            opacity: _fadeAnimation, // Bind the Animation to the image
            child: Image.asset(
              'images/logo.png', 
              height: 250, 
              width: 250
              ),
          ),
          FadeTransition(
            opacity: _fadeAnimation, // Bind the Animation to the text
            child: const Text(
              "BookTrail",
              style: TextStyle(
                color: Colors.black,
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          AnimatedPulseRectangle(opacityAnimation: _fadeAnimation),
        ],
      ),
    );
  }
}
