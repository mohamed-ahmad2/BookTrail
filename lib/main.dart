import 'package:flutter/material.dart';
import 'package:book_trail/views/main_view.dart';

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
  bool _isSplashFinished = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isSplashFinished = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Trail',
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: _isSplashFinished
          ? MainView(
              isDarkMode: _isDarkMode,
              toggleTheme: _toggleTheme,
            )
          : Scaffold(
              body: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
    );
  }
}
