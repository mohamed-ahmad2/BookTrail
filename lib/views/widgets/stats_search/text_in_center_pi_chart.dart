
import 'package:book_trail/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextInCenterPiChart extends StatelessWidget {
  final int numberOfBooks;
  const TextInCenterPiChart({super.key, required this.numberOfBooks});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            numberOfBooks.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60,
              color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF) : Colors.black,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.book,
                size: 25,
                color: themeProvider.isDarkMode ? const Color(0xFFB0BEC5) : Color(0xFF4E4E4E),
              ),
              Text(
                "Books",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: themeProvider.isDarkMode ? const Color(0xFFB0BEC5) : Color(0xFF4E4E4E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
