import 'package:book_trail/views/widgets/login_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget { 
  final bool isDarkMode;
  final Function(bool) toggleTheme;
  const LoginScreen({super.key ,required this.isDarkMode,
    required this.toggleTheme,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginBody(
      isDarkMode: widget.isDarkMode,
          toggleTheme: widget.toggleTheme,));
  }
}
