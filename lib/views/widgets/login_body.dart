import 'package:book_trail/views/widgets/login_guest_textbutton.dart';
import 'package:book_trail/views/widgets/login_logbutton.dart';
import 'package:book_trail/views/widgets/login_password.dart';
import 'package:book_trail/views/widgets/login_regbutton.dart';
import 'package:book_trail/views/widgets/login_thefirstlook.dart';
import 'package:book_trail/views/widgets/login_username.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const LoginBody({super.key ,required this.isDarkMode, required this.toggleTheme,});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginThefirstlook(),
              SizedBox(height: 25),
              LoginUsername(),
              SizedBox(height: 20),
              LoginPassword(),
              SizedBox(height: 25),
              LoginLogbutton(isDarkMode: widget.isDarkMode,
              toggleTheme: widget.toggleTheme,),
              SizedBox(height: 40),
              Text(
                '------------------------------Or------------------------------',
                style: TextStyle(
                  color: Colors.grey
                ),
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