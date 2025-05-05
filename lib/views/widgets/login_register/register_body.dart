import 'package:book_trail/book_operation.dart';
import 'package:book_trail/layout/main_layout.dart';
import 'package:book_trail/models/user.dart';
import 'package:book_trail/views/widgets/login_register/register_email.dart';
import 'package:book_trail/views/widgets/login_register/register_logbutton.dart';
import 'package:book_trail/views/widgets/login_register/register_password.dart';
import 'package:book_trail/views/widgets/login_register/register_regbutton.dart';
import 'package:book_trail/views/widgets/login_register/register_thefirstlook.dart';
import 'package:book_trail/views/widgets/login_register/register_username.dart';
import 'package:book_trail/views/screens/_login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RegisterBody extends StatefulWidget {
  final BookOperation bookOperation;
  const RegisterBody({super.key, required this.bookOperation});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _register() async {
    if (formKey.currentState!.validate()) {
      try {
        var box = await Hive.box<User>('users');
        String username = usernameController.text.trim();
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        // Check if username or email exists
        if (box.values.any((user) => user.username == username)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Username already exists !',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else if (box.values.any((user) => user.email == email)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Email already exists !',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else {
          // Add a new user
          await box.add(User(
            username: username,
            email: email,
            password: password,
          ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Registration completed successfully_😎',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainLayout(bookOperation: widget.bookOperation),
              ),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                'An error occurred during registration: $e',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }
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
              const RegisterThefirstlook(),
              const SizedBox(height: 25),
              RegisterUsername(controller: usernameController),
              const SizedBox(height: 20),
              RegisterEmail(controller: emailController),
              const SizedBox(height: 20),
              RegisterPassword(controller: passwordController),
              const SizedBox(height: 25),
              RegisterRegbutton(onPressed: _register),
              const SizedBox(height: 40),
              const Text(
                '------------------------------Or------------------------------',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              RegisterLogbutton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(bookOperation: widget.bookOperation),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}