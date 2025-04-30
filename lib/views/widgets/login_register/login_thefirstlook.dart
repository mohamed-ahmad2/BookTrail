import 'package:book_trail/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginThefirstlook extends StatefulWidget {
  const LoginThefirstlook({super.key});

  @override
  State<LoginThefirstlook> createState() => _LoginThefirstlookState();
}

class _LoginThefirstlookState extends State<LoginThefirstlook> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        SizedBox(height: 15),
        Image.asset(
          'images/logo.png',
          width: 100,
          height: 100,
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
        ),
        Center(
          child: Text(
            'BookTrail',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(height: 25),
        Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
