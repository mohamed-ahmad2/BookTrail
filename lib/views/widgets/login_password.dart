import 'package:book_trail/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPassword extends StatefulWidget {
  const LoginPassword({super.key});

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter your password !";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
    );
  }
}
