import 'package:book_trail/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPassword extends StatefulWidget {
  final TextEditingController controller;
  const LoginPassword({super.key, required this.controller});

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your Password";
        }
        if (value.length < 8) {
          return "Password must be at least 8 characters long !";
        }
        final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
        if (!passwordRegex.hasMatch(value)) {
          return "The Password must contain letters , numbers and special symbols !";
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
