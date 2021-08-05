import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/repositories/models/room_chat.dart';
import 'package:chat_app/screens/new_conversation/new_conversation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/home_app_bar.dart';
import 'widgets/item_room_chat.dart';

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
        appBar: HomeAppbar(
          name: user!.displayName,
          photoUrl: user.photoUrl,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => NewConversationScreen()));
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _firebaseMethod.getStreamRoomChat(user.uid!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length > 0) {
                List<RoomChat> listRoomChat = [];
                for (var doc in snapshot.data!.docs) {
                  final roomChat = RoomChat.fromJson(doc.data());
                  listRoomChat.add(roomChat);
                }
                listRoomChat
                    .sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
                return ListView.builder(
                  itemCount: listRoomChat.length,
                  itemBuilder: (context, index) => ItemRoomChat(
                    userId: user.uid!,
                    firebaseMethod: _firebaseMethod,
                    roomChat: listRoomChat[index],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "Chưa có cuộc hội thoại nào",
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
