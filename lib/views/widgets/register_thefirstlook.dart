import 'package:flutter/material.dart';

class RegisterThefirstlook extends StatefulWidget {
  const RegisterThefirstlook({super.key});

  @override
  State<RegisterThefirstlook> createState() => _RegisterThefirstlookState();
}

class _RegisterThefirstlookState extends State<RegisterThefirstlook> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://cdn-icons-png.flaticon.com/512/4/4259.png',
          width: 100,
        ),
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
            'Register',
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
