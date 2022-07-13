import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_texfield.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_button.dart';
import './signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) {
    return setState(() {
      rememberMe = newValue;
      if (rememberMe) {
        // TODO: Here goes your functionality that remembers the user.
      } else {
        // TODO: Forget the user
      }
    });
  }

  void _signIn() {
    authService.signInUser(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 30),
                  child: const AppText(
                    text: 'Sign In',
                    size: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomTextField(
                  hintText: '',
                  labelText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: '*******',
                  labelText: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          value: rememberMe,
                          onChanged: (newValue) =>
                              _onRememberMeChanged(newValue!),
                        ),
                        const SizedBox(width: 10),
                        const AppText(text: 'Remember me'),
                      ],
                    ),
                    CustomTextButton(
                      text: 'Forgot Password?',
                      color: const Color(0xFF0E1467),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sign In',
                  height: 40,
                  onPressed: _signIn,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const AppText(text: 'Not a user?', size: 14),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                      },
                      text: 'Sign Up',
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
