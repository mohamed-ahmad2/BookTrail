import 'package:flutter/material.dart';

class RegisterRegbutton extends StatefulWidget {
  const RegisterRegbutton({super.key});

  @override
  State<RegisterRegbutton> createState() => _RegisterRegbuttonState();
}

class _RegisterRegbuttonState extends State<RegisterRegbutton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 400,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: () {
          
        },
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
