import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/repositories/models/room_chat.dart';
import 'package:chat_app/screens/new_conversation/new_conversation_screen.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'item_room_chat.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({
    Key? key,
    required FirebaseMethod firebaseMethod,
    required this.user,
  })  : _firebaseMethod = firebaseMethod,
        super(key: key);

  final FirebaseMethod _firebaseMethod;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firebaseMethod.getStreamRoomChat(user.uid!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.length > 0) {
            List<RoomChat> listRoomChat = [];
            for (var doc in snapshot.data!.docs) {
              final roomChat = RoomChat.fromJson(doc.data());
              listRoomChat.add(roomChat);
            }
            listRoomChat.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));

            return ListView.builder(
              padding: EdgeInsets.only(top: 30),
              itemCount: listRoomChat.length,
              itemBuilder: (context, index) => ItemRoomChat(
                userId: user.uid!,
                firebaseMethod: _firebaseMethod,
                roomChat: listRoomChat[index],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 56),
                    child: Text(
                      "You haven't messaged anyone yet",
                      textAlign: TextAlign.center,
                      style: txtMedium(24),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => NewConversationScreen()));
                      },
                      icon: SvgPicture.asset(searchIcon,
                          width: 24, height: 24, color: primaryColor),
                      label: Text(
                        "Find new friends",
                        style: txtMedium(24, primaryColor),
                      ))
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
