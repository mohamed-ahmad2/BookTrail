import 'package:flutter/material.dart';

class LoginThefirstlook extends StatefulWidget {
  const LoginThefirstlook({super.key});

  @override
  State<LoginThefirstlook> createState() => _LoginThefirstlookState();
}

class _LoginThefirstlookState extends State<LoginThefirstlook> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        Image.asset('images/logo.png', width: 100, height: 100,),
        Center(
          child: Text(
            'BookTrail',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 25),
        Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
