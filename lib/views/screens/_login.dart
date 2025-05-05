import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/widgets/login_register/login_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final BookOperation bookOperation;
  const LoginScreen({super.key, required this.bookOperation});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(bookOperation: widget.bookOperation),
    );
  }
}
