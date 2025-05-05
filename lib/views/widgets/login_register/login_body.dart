import 'package:book_trail/book_operation.dart';
import 'package:book_trail/layout/main_layout.dart';
import 'package:book_trail/models/user.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/providers/username_provider.dart';
import 'package:book_trail/views/widgets/login_register/login_guest_textbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_logbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_password.dart';
import 'package:book_trail/views/widgets/login_register/login_regbutton.dart';
import 'package:book_trail/views/widgets/login_register/login_thefirstlook.dart';
import 'package:book_trail/views/widgets/login_register/login_username.dart';
import 'package:book_trail/views/screens/_register.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  final BookOperation bookOperation;
  const LoginBody({super.key, required this.bookOperation});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() async {
    if (formKey.currentState!.validate()) {
      try {
        var box = Hive.box<User>('users');
        String username = usernameController.text.trim();
        String password = passwordController.text.trim();

        User? user = box.values.firstWhere(
          (user) => user.username == username && user.password == password,
          orElse: () => User(username: '', password: '', email: ''),
        );

        if (user.username.isNotEmpty) {
          if (mounted) {
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).setUserId(user.username);

            Provider.of<UsernameProvider>(
              context,
              listen: false,
            ).setUsername(user.username);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        MainLayout(bookOperation: widget.bookOperation),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Incorrect username or password!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        debugPrint('Error during login: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text(
                'Failed to login. Please try again.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      debugPrint('Form validation failed');
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
              const SizedBox(height: 40),
              const LoginThefirstlook(),
              const SizedBox(height: 25),
              LoginUsername(controller: usernameController),
              const SizedBox(height: 20),
              LoginPassword(controller: passwordController),
              const SizedBox(height: 25),
              LoginLogbutton(
                onPressed: _login,
                bookOperation: widget.bookOperation,
              ),
              const SizedBox(height: 40),
              const Text(
                '------------------------------Or------------------------------',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              LoginRegbutton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                Register(bookOperation: widget.bookOperation),
                      ),
                    ),
              ),
              const SizedBox(height: 30),
              LoginGuestTextbutton(bookOperation: widget.bookOperation),
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
