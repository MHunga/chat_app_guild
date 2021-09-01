import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/screens/auth/widgets/full_screen_circular_progress.dart';
import 'package:chat_app/screens/auth/widgets/header_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'widgets/body_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 12),
                  HeaderSignIn(),
                  BodySignIn(
                      emailEditingController: emailEditingController,
                      passwordEditingController: passwordEditingController),
                ],
              ),
            ),
          ),
        ),
        if (context.watch<AuthController>().isLoading)
          CircularProgressFullScreen()
      ],
    );
  }
}
