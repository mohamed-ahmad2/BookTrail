import 'package:book_trail/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorTextPiChart extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  const ColorTextPiChart({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: category['color'],
                      ),
                    ),

                    SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        category['name'],
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
                      category['value'].toString(),
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
            }).toList(),
      ),
    );
  }
}
