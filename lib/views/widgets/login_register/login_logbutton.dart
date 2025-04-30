import 'package:book_trail/views/home_screen.dart';
import 'package:flutter/material.dart';

class LoginLogbutton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginLogbutton({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  State<LoginLogbutton> createState() => _LoginLogbuttonState();
}

class _LoginLogbuttonState extends State<LoginLogbutton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 400,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF65558f),
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
          'Log in',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
