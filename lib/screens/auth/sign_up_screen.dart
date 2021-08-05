import 'package:chat_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'widgets/auth_button.dart';
import 'widgets/auth_text_input.dart';
import 'package:provider/provider.dart';

import 'widgets/full_screen_circular_progress.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Đăng ký"),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: FlutterLogo(size: 100),
                  ),
                  AuthTextInput(
                    controller: nameEditingController,
                    lableText: "Name",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  AuthTextInput(
                    controller: emailEditingController,
                    lableText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  AuthTextInput(
                    controller: passwordEditingController,
                    lableText: "Password",
                    keyboardType: TextInputType.text,
                    obscure: true,
                  ),
                  SizedBox(height: 24),
                  AuthButton(
                      onTap: () async {
                        await context.read<AuthController>().createAccount(
                            name: nameEditingController.text.trim(),
                            email: emailEditingController.text.trim(),
                            password: passwordEditingController.text.trim());
                        Navigator.pop(context);
                      },
                      title: "Đăng ký"),
                ],
              ),
            ),
          ),
        ),
      if (context.watch<AuthController>().isLoading) CircularProgressFullScreen()
      ],
    );
  }
}
