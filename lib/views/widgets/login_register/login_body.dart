import 'package:book_trail/models/user.dart';
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
      var box = Hive.box<User>('users');
      print('All users: ${box.values.toList()}'); // للتصحيح
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      User? user = box.values.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => User(username: '', password: '', email: ''),
      );

      if (user.username.isNotEmpty) {
        // الانتقال إلى HomeScreen
        Navigator.pushReplacementNamed(context, '/mainLayout');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('اسم المستخدم أو كلمة المرور غير صحيحة')),
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
                onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
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
