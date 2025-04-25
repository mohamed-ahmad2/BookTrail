import 'package:flutter/material.dart';

class RegisterLogbutton extends StatefulWidget {
  const RegisterLogbutton({super.key});

  @override
  State<RegisterLogbutton> createState() => _RegisterLogbuttonState();
}

class _RegisterLogbuttonState extends State<RegisterLogbutton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 87, 55, 61),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: () {
          print('Log in');
        },
        child: const Text(
          'Log in',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
