import 'package:book_trail/models/user.dart';
import 'package:book_trail/views/widgets/login_register/register_email.dart';
import 'package:book_trail/views/widgets/login_register/register_logbutton.dart';
import 'package:book_trail/views/widgets/login_register/register_password.dart';
import 'package:book_trail/views/widgets/login_register/register_regbutton.dart';
import 'package:book_trail/views/widgets/login_register/register_thefirstlook.dart';
import 'package:book_trail/views/widgets/login_register/register_username.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

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
      var box = Hive.box<User>('users');
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // التحقق مما إذا كان اسم المستخدم أو البريد الإلكتروني موجودًا
      if (box.values.any((user) => user.username == username)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('اسم المستخدم موجود بالفعل!')),
        );
      } else if (box.values.any((user) => user.email == email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('البريد الإلكتروني موجود بالفعل!')),
        );
      } else {
        // إضافة مستخدم جديد
        await box.add(User(
          username: username,
          email: email,
          password: password,
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التسجيل بنجاح!')),
        );
        Navigator.pushReplacementNamed(context, '/login');
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
                '--------------------------------------Or--------------------------------------',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              RegisterLogbutton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
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
