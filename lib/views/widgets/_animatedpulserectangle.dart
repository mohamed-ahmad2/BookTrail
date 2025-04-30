import 'package:book_trail/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedPulseRectangle extends StatefulWidget {
  final Animation<double> opacityAnimation;
  const AnimatedPulseRectangle({super.key, required this.opacityAnimation});

  @override
  State<AnimatedPulseRectangle> createState() => _AnimatedPulseRectangleState();
}

class _AnimatedPulseRectangleState extends State<AnimatedPulseRectangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _widthAnimation = Tween<double>(
      begin: 20.0,
      end: 60.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return FadeTransition(
      opacity: widget.opacityAnimation,
      child: AnimatedBuilder(
        animation: _widthAnimation,
        builder: (context, child) {
          return Container(
            width: _widthAnimation.value,
            height: 10,
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        },
      ),
    );
  }
}
