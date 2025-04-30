import 'package:book_trail/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterThefirstlook extends StatefulWidget {
  const RegisterThefirstlook({super.key});

  @override
  State<RegisterThefirstlook> createState() => _RegisterThefirstlookState();
}

class _RegisterThefirstlookState extends State<RegisterThefirstlook> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
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
            'Register',
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
