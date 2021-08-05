import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/screens/change_profile/change_profile_screen.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({Key? key, this.name, this.photoUrl}) : super(key: key);
  final String? name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ChangeProfileScreen()));
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              context.read<AuthController>().signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            )),
      ],
      title: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
        child: photoUrl != null
            ? null
            : Text(Utils.nameInit(name ?? ""),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
