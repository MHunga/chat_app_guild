import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';

class HeaderSignIn extends StatelessWidget {
  const HeaderSignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome to", style: txtSemiBold(18)),
              Text(
                "Amazin Chat",
                style: txtSemiBold(32, primaryColor),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: Hero(tag: amzChatIcon, child: Image.asset(amzChatIcon)),
            ),
          ))
        ],
      ),
    );
  }
}
