import 'package:book_trail/layout/main_layout.dart';
import 'package:flutter/material.dart';

class LoginLogbutton extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const LoginLogbutton({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<LoginLogbutton> createState() => _LoginLogbuttonState();
}

class _LoginLogbuttonState extends State<LoginLogbutton> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 55,
            width: 400,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF65558f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MainLayout(
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme,
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Log in',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
