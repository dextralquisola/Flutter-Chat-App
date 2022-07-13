import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_texfield.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_button.dart';
import './login_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    _authService.signUpUser(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
      context: context,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 15),
                  child: const AppText(
                    text: 'Sign Up',
                    size: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: '',
                  labelText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: '',
                  labelText: 'Email Address',
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: '*******',
                  labelText: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sign up',
                  onPressed: signUp,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const AppText(text: 'Already a user?', size: 14),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      text: 'Sign In',
                      color: const Color(0xFF0E1467),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
