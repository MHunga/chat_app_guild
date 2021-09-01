import 'package:chat_app/controllers/auth_controller.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'widgets/body_sign_up.dart';
import 'widgets/full_screen_circular_progress.dart';
import 'widgets/header_sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  HeaderSignUp(),
                  BodySignUp(
                      formKey: formKey,
                      nameEditingController: nameEditingController,
                      emailEditingController: emailEditingController,
                      passwordEditingController: passwordEditingController,
                      confirmPasswordEditingController:
                          confirmPasswordEditingController),
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
