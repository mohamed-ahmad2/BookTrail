import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/widgets/login_register/register_body.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final BookOperation bookOperation;
  const Register({super.key, required this.bookOperation});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RegisterBody(bookOperation: widget.bookOperation));
  }
}
