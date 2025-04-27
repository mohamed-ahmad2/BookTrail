//import 'package:book_trail/views/book_info.dart';
import 'package:book_trail/views/settings_screen.dart';
import 'package:flutter/material.dart';

// check
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      title: 'Book Trail',
      debugShowCheckedModeBanner: false,
      home: //const BookInfo(), 
      SettingsScreen(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
    );
  }
}
