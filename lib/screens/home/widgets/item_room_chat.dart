import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/repositories/models/room_chat.dart';
import 'package:chat_app/screens/conversation/conversation_screen.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemRoomChat extends StatelessWidget {
  const ItemRoomChat({
    Key? key,
    required this.roomChat,
    required this.userId,
    required this.firebaseMethod,
  }) : super(key: key);
  final String userId;
  final RoomChat roomChat;
  final FirebaseMethod firebaseMethod;

  @override
  Widget build(BuildContext context) {
    String receiverId =
        roomChat.membersId!.firstWhere((element) => element != userId);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: firebaseMethod.getStreamUser(receiverId),
        builder: (context, snapshot) {
          AppUser? receiver;
          if (snapshot.hasData) {
            final data = snapshot.data!.data();
            receiver = AppUser.fromJson(data!);
          }
          return InkWell(
            onTap: () {
              if (receiver != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ConversationScreen(
                              receiver: receiver!,
                              chatRoomId: roomChat.id,
                            )));
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 2),
                      image: receiver != null
                          ? receiver.photoUrl != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(receiver.photoUrl!))
                              : null
                          : null,
                    ),
                    child: receiver == null
                        ? null
                        : receiver.photoUrl != null
                            ? null
                            : Center(
                                child: Text(
                                    Utils.nameInit(receiver.displayName ?? ""),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                              ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            receiver != null
                                ? receiver.displayName ?? ""
                                : "Name",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            _timeStamp(roomChat.timeStamp ?? 0),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              roomChat.message ?? "message",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container())
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Divider()
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }

  _timeStamp(int milisecond) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final duration = now - milisecond;
    if (duration <= 60000) {
      return "Vừa xong";
    } else {
      final minute = (duration / 60000).floor();
      if (minute >= 1 && minute < 60) {
        return "$minute phút trước";
      } else if (minute > 60 && minute < 24 * 60) {
        return "${(minute / 60).floor()} giờ trước";
      } else {
        final date = DateTime.fromMillisecondsSinceEpoch(milisecond);
        return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
      }
    }
  }
}
