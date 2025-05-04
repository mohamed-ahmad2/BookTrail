import 'package:flutter/material.dart';

class RegisterEmail extends StatefulWidget {
  final TextEditingController controller;

  const RegisterEmail({super.key, required this.controller});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // استخدام widget.controller
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter your Email !";
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3,}$').hasMatch(value)) {
          return "please enter a valid Email !";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: 'Email',
        hintText: 'Enter your Email',
      ),
    );
  }
}
