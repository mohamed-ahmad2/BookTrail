import 'package:book_trail/layout/main_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BookTrailApp());
}

class BookTrailApp extends StatefulWidget {
  const BookTrailApp({super.key});

  @override
  State<BookTrailApp> createState() => _BookTrailAppState();
}

class _BookTrailAppState extends State<BookTrailApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Trail',
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MainLayout(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
    );
  }
}
