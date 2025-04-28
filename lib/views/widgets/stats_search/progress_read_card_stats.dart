import 'package:book_trail/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressReadCardStats extends StatelessWidget {
  final int numberOfPages;
  final int totalPages;
  const ProgressReadCardStats({
    super.key,
    required this.numberOfPages,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double progress = numberOfPages / totalPages;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            numberOfPages.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  themeProvider.isDarkMode
                      ? const Color(0xFFFFFFFF)
                      : Colors.black,
              fontSize: 24,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Read pages of ${totalPages.toString()} total pages from all books',
            style: TextStyle(
              fontSize: 14,
              color:
                  themeProvider.isDarkMode
                      ? const Color(0xFFB0BEC5)
                      : Colors.grey[600],
            ),
          ),

          SizedBox(height: 8),

          LinearProgressIndicator(
            value: progress,
            backgroundColor:
                themeProvider.isDarkMode
                    ? const Color(0xFF424242)
                    : Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              themeProvider.isDarkMode ? const Color(0xFF64B5F6) : Colors.blue,
            ),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
