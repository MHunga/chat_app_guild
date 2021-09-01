import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderConversation extends StatelessWidget {
  const HeaderConversation({Key? key, required this.receiver})
      : super(key: key);

  final AppUser receiver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(backIcon,
                width: 30, height: 30, color: primaryColor),
          ),
          SizedBox(width: 16),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.withOpacity(0.6),
            backgroundImage: receiver.photoUrl != null
                ? NetworkImage(receiver.photoUrl!)
                : null,
            child: receiver.photoUrl != null
                ? null
                : Text(Utils.nameInit(receiver.displayName ?? ""),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
          ),
          SizedBox(width: 16),
          Text(
            receiver.displayName ?? "",
            style: txtSemiBold(18),
          )
        ],
      ),
    );
  }
}
