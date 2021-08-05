import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ConversationAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const ConversationAppbar({
    Key? key,
    required this.receiver,
  }) : super(key: key);
  final AppUser receiver;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
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
          SizedBox(
            width: 16,
          ),
          Text(
            receiver.displayName ?? "",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      bottom: PreferredSize(
        child: Divider(),
        preferredSize: Size(double.infinity, 2),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
