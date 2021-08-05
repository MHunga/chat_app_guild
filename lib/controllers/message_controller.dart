import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/repositories/models/message.dart';
import 'package:chat_app/repositories/models/room_chat.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MessageController extends ChangeNotifier {
  final FirebaseMethod _firebaseMethod = FirebaseMethod();
  final AppUser user;
  final AppUser? receiver;
  String? chatRoomId;
  bool isLoading = true;
  List<Message> listMessage = [];

  MessageController(
      {required this.user, required this.receiver, required this.chatRoomId}) {
    _init();
  }

  Future _init() async {
    if (chatRoomId == null && receiver != null) {
      chatRoomId =
          await _firebaseMethod.getIdRoomChat(user.uid!, receiver!.uid!);
      print(chatRoomId);
    }
    isLoading = false;
    notifyListeners();
  }

  void onSend({required String mess}) async {
    final roomId = chatRoomId != null ? chatRoomId : Uuid().v4();
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    await _firebaseMethod.sendMessage(
      roomChat: RoomChat(
        id: roomId,
        membersId: [user.uid!, receiver!.uid!],
        message: mess,
        senderId: user.uid,
        timeStamp: timeStamp,
      ),
      message: Message(
          id: Uuid().v4(),
          message: mess,
          roomChatId: roomId,
          senderId: user.uid,
          senderName: user.displayName,
          timeStamp: timeStamp),
    );
    if (chatRoomId == null && receiver != null) {
      chatRoomId =
          await _firebaseMethod.getIdRoomChat(user.uid!, receiver!.uid!);
    }
    notifyListeners();
  }
}
