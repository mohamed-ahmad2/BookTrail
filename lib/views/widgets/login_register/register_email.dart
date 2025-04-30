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
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your Email";
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return "Please enter a valid Email !";
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
