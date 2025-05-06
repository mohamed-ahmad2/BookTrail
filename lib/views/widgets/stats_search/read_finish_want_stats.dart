import 'package:book_trail/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadFinishWantStats extends StatelessWidget {
  final double count;
  final IconData iconStats;
  final String nameStats;
  const ReadFinishWantStats({
    super.key,
    required this.count,
    required this.iconStats,
    required this.nameStats,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Icon(
            iconStats,
            size: 24,
            color:
                themeProvider.isDarkMode
                    ? const Color(0xFFFFFFFF)
                    : Colors.black,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              nameStats,
              style: TextStyle(
                fontSize: 16,
                color:
                    themeProvider.isDarkMode
                        ? const Color(0xFFFFFFFF)
                        : Colors.black,
              ),
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:
                  themeProvider.isDarkMode
                      ? const Color(0xFFFFFFFF)
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
