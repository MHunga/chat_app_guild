import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/screens/new_conversation/new_conversation_screen.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'widgets/body_home.dart';
import 'widgets/header_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMethod _firebaseMethod = FirebaseMethod();
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().appUser;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => NewConversationScreen()));
          },
          child: SvgPicture.asset(searchIcon,
              height: 24, width: 24, color: Colors.white),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  child: HeaderHome(user: user!)),
              Expanded(
                  child: BodyHome(firebaseMethod: _firebaseMethod, user: user)),
            ],
          ),
        ));
  }
}
