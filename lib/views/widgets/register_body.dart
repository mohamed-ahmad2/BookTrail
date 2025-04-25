import 'package:book_trail/views/widgets/register_email.dart';
import 'package:book_trail/views/widgets/register_logbutton.dart';
import 'package:book_trail/views/widgets/register_password.dart';
import 'package:book_trail/views/widgets/register_regbutton.dart';
import 'package:book_trail/views/widgets/register_thefirstlook.dart';
import 'package:book_trail/views/widgets/register_username.dart';
import 'package:flutter/material.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RegisterThefirstlook(),
            SizedBox(height: 25),
            RegisterUsername(),
            SizedBox(height: 20),
            RegisterEmail(),
            SizedBox(height: 20),
            RegisterPassword(),
            SizedBox(height: 25),
            RegisterRegbutton(),
            SizedBox(height: 40),
            Text('--------------------------------------Or--------------------------------------'),
            SizedBox(height: 25),
            RegisterLogbutton(),
          ],
        ),
    );
  }
}
