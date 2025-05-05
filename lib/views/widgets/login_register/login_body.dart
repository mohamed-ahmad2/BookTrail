import 'package:book_trail/layout/main_layout.dart';
import 'package:book_trail/models/user.dart';
import 'package:book_trail/views/_register.dart';
import 'package:book_trail/views/widgets/login_register/login_guest_textbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_logbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_password.dart';
import 'package:book_trail/views/widgets/login_register/login_regbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_thefirstlook.dart';
import 'package:book_trail/views/widgets/login_register/login_username.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() async {
    if (formKey.currentState!.validate()) {
      try {
        var box = Hive.box<User>('users');
        print('All users: ${box.values.toList()}');
        String username = usernameController.text.trim();
        String password = passwordController.text.trim();
        print('Username: $username, Password: $password'); // To verify the entered values

        User? user = box.values.firstWhere(
          (user) => user.username == username && user.password == password,
          orElse: () => User(username: '', password: '', email: ''),
        );

        if (user.username.isNotEmpty) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainLayout()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                  child: Text(
                  'Incorrect username or password !',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }
      } catch (e) {
        print('Error during login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred during login: $e')),
        );
      }
    } else {
      print('Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LoginThefirstlook(),
              const SizedBox(height: 25),
              LoginUsername(controller: usernameController),
              const SizedBox(height: 20),
              LoginPassword(controller: passwordController),
              const SizedBox(height: 25),
              LoginLogbutton(onPressed: _login),
              const SizedBox(height: 40),
              const Text(
                '------------------------------Or------------------------------',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              LoginRegbutton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                ),
              ),
              const SizedBox(height: 30),
              const LoginGuestTextbutton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
