

import 'package:book_trail/book_operation.dart';
import 'package:flutter/material.dart';

class LoginLogbutton extends StatelessWidget {
  final VoidCallback onPressed;
  final BookOperation bookOperation;
  const LoginLogbutton({super.key, required this.bookOperation, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 400,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF65558f),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          'Log in',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
