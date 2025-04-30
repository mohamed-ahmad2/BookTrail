import 'package:book_trail/views/widgets/login_register/register_email.dart';
import 'package:book_trail/views/widgets/login_register/register_logbutton.dart';
import 'package:book_trail/views/widgets/login_register/register_password.dart';
import 'package:book_trail/views/widgets/login_register/register_regbutton.dart';
import 'package:book_trail/views/widgets/login_register/register_thefirstlook.dart';
import 'package:book_trail/views/widgets/login_register/register_username.dart';
import 'package:flutter/material.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RegisterThefirstlook(),
              SizedBox(height: 25),
              RegisterUsername(controller: _usernameController),
              SizedBox(height: 20),
              RegisterEmail(controller: _emailController),
              SizedBox(height: 20),
              RegisterPassword(controller: _passwordController),
              SizedBox(height: 25),
              RegisterRegbutton(
                formKey: _formKey,
                usernameController: _usernameController,
                emailController: _emailController,
                passwordController: _passwordController,
              ), // زر التسجيل
              SizedBox(height: 40),
              Text(
                '------------------------------Or------------------------------',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 25),
              RegisterLogbutton(),
            ],
          ),
        ),
      ),
    );
  }
}
