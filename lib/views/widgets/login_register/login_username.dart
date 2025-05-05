import 'package:flutter/material.dart';

class LoginUsername extends StatefulWidget {
  final TextEditingController controller;

  const LoginUsername({super.key, required this.controller});
  @override
  State<LoginUsername> createState() => _LoginUsernameState();
}

class _LoginUsernameState extends State<LoginUsername> {
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please enter your Username !";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: 'Username',
        hintText: 'Enter your Username',
      ),
    );
  }
}
