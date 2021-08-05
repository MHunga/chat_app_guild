import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/screens/auth/sign_up_screen.dart';
import 'package:chat_app/screens/auth/widgets/full_screen_circular_progress.dart';
import 'package:flutter/material.dart';

import 'widgets/auth_button.dart';
import 'widgets/auth_text_input.dart';
import 'package:provider/provider.dart';

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
          appBar: AppBar(
            title: Text("Đăng nhập"),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: FlutterLogo(size: 100),
                  ),
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
                      onTap: () {
                        context
                            .read<AuthController>()
                            .signInWithEmailAndPassword(
                                email: emailEditingController.text.trim(),
                                password:
                                    passwordEditingController.text.trim());
                      },
                      title: "Đăng nhập"),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Text("Chưa có tài khoản? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUpScreen()));
                          },
                          child: Text("Đăng ký"))
                    ],
                  )
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
