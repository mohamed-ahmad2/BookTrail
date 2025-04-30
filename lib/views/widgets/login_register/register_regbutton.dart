import 'package:book_trail/views/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String? _errorMessage;
  bool _isLoading = false;

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل';
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جدًا';
      default:
        return 'حدث خطأ: $code';
    }
  }

  Future<void> _register() async {
    if (widget.formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        // التحقق من أن اسم المستخدم غير مستخدم
        final usernameSnapshot =
            await FirebaseFirestore.instance
                .collection('usernames')
                .doc(widget.usernameController.text.trim())
                .get();
        if (usernameSnapshot.exists) {
          setState(() {
            _errorMessage = 'اسم المستخدم مستخدم بالفعل';
          });
          return;
        }

        // إنشاء حساب في Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: widget.emailController.text.trim(),
              password: widget.passwordController.text.trim(),
            );

        // تخزين بيانات المستخدم في users
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
              'username': widget.usernameController.text.trim(),
              'email': widget.emailController.text.trim(),
              'createdAt': FieldValue.serverTimestamp(),
            });

        // تخزين اسم المستخدم في usernames
        await FirebaseFirestore.instance
            .collection('usernames')
            .doc(widget.usernameController.text.trim())
            .set({
              'email': widget.emailController.text.trim(),
              'userId': userCredential.user!.uid,
            });

        // تسجيل حدث إنشاء حساب في Analytics
        await FirebaseAnalytics.instance.logSignUp(signUpMethod: 'email');

        // الانتقال إلى HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => HomeScreen(
                  tabController: TabController(
                    length: 4,
                    vsync: Navigator.of(context),
                  ),
                ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = _mapFirebaseError(e.code);
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'حدث خطأ: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        SizedBox(
          height: 55,
          width: 400,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            onPressed: _isLoading ? null : _register,
            child:
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
