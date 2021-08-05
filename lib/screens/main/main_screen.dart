import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/screens/auth/sign_in_screen.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.watch<AuthController>().authStatus;
    switch (status) {
      case AuthStatus.authenticate:
        return HomeScreen();
      case AuthStatus.unauthenticate:
        return SignInScreen();
      default:
        return SplashScreen();
    }
  }
}
