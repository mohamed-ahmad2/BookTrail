import 'package:book_trail/views/_register.dart';
import 'package:flutter/material.dart';

class LoginRegbutton extends StatefulWidget {
  const LoginRegbutton({super.key});

  @override
  State<LoginRegbutton> createState() => _LoginRegbuttonState();
}

class _LoginRegbuttonState extends State<LoginRegbutton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF492532),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );
        },
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
