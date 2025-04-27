// import 'package:book_trail/views/main_view.dart';
// import 'package:book_trail/layout/main_layout.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const BookTrailApp());
// }

// class BookTrailApp extends StatefulWidget {
//   const BookTrailApp({super.key});

//   @override
//   State<BookTrailApp> createState() => _BookTrailAppState();
// }

// class _BookTrailAppState extends State<BookTrailApp> {
//   bool _isDarkMode = false;

//   void _toggleTheme(bool value) {
//     setState(() {
//       _isDarkMode = value;
//     });
//   }


// void main() {
//   runApp(const Splash());
// }

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
  

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Book Trail',
//       debugShowCheckedModeBanner: false,
//       theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       home: MainView(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
//     );
//   }
// }
// }
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
      home: Splash(
        isDarkMode: _isDarkMode,
        toggleTheme: _toggleTheme,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const Splash({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // تنتظر 2 ثانية ثم تذهب إلى MainView
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainView(
          isDarkMode: widget.isDarkMode,
          toggleTheme: widget.toggleTheme,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to Book Trail',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
