import 'package:flutter/material.dart';

class RegisterUsername extends StatefulWidget {
  const RegisterUsername({super.key});

  @override
  State<RegisterUsername> createState() => _RegisterUsernameState();
}

class _RegisterUsernameState extends State<RegisterUsername> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernameController,
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
