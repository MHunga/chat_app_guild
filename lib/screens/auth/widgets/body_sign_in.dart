import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../sign_up_screen.dart';
import 'auth_button.dart';
import 'auth_text_input.dart';
import 'package:provider/provider.dart';

class BodySignIn extends StatelessWidget {
  const BodySignIn({
    Key? key,
    required this.emailEditingController,
    required this.passwordEditingController,
  }) : super(key: key);

  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          AuthTextInput(
            controller: emailEditingController,
            lableText: "Email",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 30),
          AuthTextInput(
            controller: passwordEditingController,
            lableText: "Password",
            keyboardType: TextInputType.text,
            obscure: true,
          ),
          SizedBox(height: 30),
          AuthButton(
              onTap: () {
                context.read<AuthController>().signInWithEmailAndPassword(
                    email: emailEditingController.text.trim(),
                    password: passwordEditingController.text.trim());
              },
              title: "Sign In"),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                "Do not have an account? ",
                style: txtRegular(14),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()));
                  },
                  child: Text(
                    "Sign Up",
                    style: txtSemiBold(18, primaryColor),
                  ))
            ],
          ),
          SizedBox(height: 50),
          Row(
            children: [
              Expanded(child: Divider(color: secondaryColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "OR",
                  style: txtBold(16),
                ),
              ),
              Expanded(child: Divider(color: secondaryColor)),
            ],
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () async {
              await context.read<AuthController>().signInWithGoogle();
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: secondaryColor, width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      googleIcon,
                      width: 30,
                      height: 30,
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                      "Sign in with Google",
                      style: txtMedium(24, Colors.blue),
                    )))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
