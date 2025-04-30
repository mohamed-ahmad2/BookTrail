import 'package:book_trail/views/home_screen.dart';
import 'package:flutter/material.dart';

class RegisterRegbutton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterRegbutton({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<RegisterRegbutton> createState() => _RegisterRegbuttonState();
}

class _RegisterRegbuttonState extends State<RegisterRegbutton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 400,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  tabController: TabController(length: 4, vsync: Navigator.of(context)),
                ),
              ),
            );
          }
        },
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
