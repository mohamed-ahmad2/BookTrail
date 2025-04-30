import 'package:book_trail/views/widgets/login_register/login_guest_textbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_logbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_password.dart';
import 'package:book_trail/views/widgets/login_register/login_regbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_thefirstlook.dart';
import 'package:book_trail/views/widgets/login_register/login_username.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
              LoginThefirstlook(),
              SizedBox(height: 25),
              LoginUsername(controller: _usernameController),
              SizedBox(height: 20),
              LoginPassword(controller: _passwordController),
              SizedBox(height: 25),
              LoginLogbutton(
                formKey: _formKey,
                usernameController: _usernameController,
                passwordController: _passwordController,
              ),
              SizedBox(height: 40),
              Text(
                '------------------------------Or------------------------------',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 25),
              LoginRegbutton(),
              SizedBox(height: 30),
              LoginGuestTextbutton(),
            ],
          ),
        ),
      ),
    );
  }
}
