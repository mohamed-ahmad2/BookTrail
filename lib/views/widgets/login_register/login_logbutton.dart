import 'package:book_trail/book_operation.dart';
import 'package:book_trail/layout/main_layout.dart';
import 'package:flutter/material.dart';

class LoginLogbutton extends StatefulWidget {
    final BookOperation bookOperation;
  const LoginLogbutton({super.key, required this.bookOperation});

  @override
  State<LoginLogbutton> createState() => _LoginLogbuttonState();
}

class _LoginLogbuttonState extends State<LoginLogbutton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 400,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF65558f),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => MainLayout(bookOperation: widget.bookOperation)));
        },
        child: const Text(
          'Log in',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
