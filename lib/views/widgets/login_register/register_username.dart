import 'package:flutter/material.dart';

class RegisterUsername extends StatefulWidget {
  final TextEditingController controller;

  const RegisterUsername({super.key, required this.controller});
  @override
  State<RegisterUsername> createState() => _RegisterUsernameState();
}

class _RegisterUsernameState extends State<RegisterUsername> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // استخدام widget.controller
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter your Username !";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: 'Username',
        hintText: 'Enter your Username',
      ),
    );
  }
}
