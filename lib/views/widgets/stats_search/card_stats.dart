import 'package:book_trail/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardStats extends StatelessWidget {
  final List<Widget> cards;
  const CardStats({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Card(
        elevation: 4,
        color:
            themeProvider.isDarkMode
                ? const Color(0xFF252526)
                : Color(0xFFF4F4F4),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        child: Column(children: cards),
      ),
    );
  }
}
