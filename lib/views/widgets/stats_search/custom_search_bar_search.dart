import 'package:book_trail/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchBarSearch extends StatelessWidget {
  final Function(String) onSearch;
  const CustomSearchBarSearch({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        onChanged: (value) {
          onSearch(value); // Call onSearch on every input change
        },
        onSubmitted: (value) {
          onSearch(value); // Also call onSearch on submit
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: themeProvider.isDarkMode ? const Color(0xFF2E2E2E) : const Color(0xFFECE6F0),
          hintText: "search text",
          prefixIcon: Icon(Icons.search),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 17),
            child: Icon(Icons.qr_code_scanner),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
