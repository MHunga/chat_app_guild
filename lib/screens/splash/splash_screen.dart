import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: amzChatIcon,
          child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(amzChatIcon),
          ),
        ),
      ),
    );
  }
}
