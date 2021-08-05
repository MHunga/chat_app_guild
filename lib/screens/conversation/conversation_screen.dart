import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/controllers/message_controller.dart';
import 'package:chat_app/repositories/firebase/firebase_method.dart';
import 'package:chat_app/repositories/models/app_user.dart';
import 'package:chat_app/repositories/models/message.dart';
import 'package:chat_app/screens/conversation/widgets/input_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/conversation_appbar.dart';
import 'widgets/message_item.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key, required this.receiver, this.chatRoomId})
      : super(key: key);
  final AppUser receiver;
  final String? chatRoomId;

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  FirebaseMethod _firebaseMethod = FirebaseMethod();
  TextEditingController _messController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthController>().appUser!;
    return ChangeNotifierProvider<MessageController>(
      create: (_) => MessageController(
          user: user, receiver: widget.receiver, chatRoomId: widget.chatRoomId),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: ConversationAppbar(receiver: widget.receiver),
            body: context.watch<MessageController>().isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        context.watch<MessageController>().chatRoomId != null
                            ? StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                stream: _firebaseMethod.getStreamMessage(context
                                    .watch<MessageController>()
                                    .chatRoomId!),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Expanded(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  List<Message> listMessage = snapshot
                                      .data!.docs
                                      .map<Message>(
                                          (e) => Message.fromJson(e.data()))
                                      .toList();
                                  print(listMessage.length);
                                  return Expanded(
                                      child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 24),
                                    itemCount: listMessage.length,
                                    reverse: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        MessageItem(
                                      listMessage: listMessage,
                                      index: index,
                                      isMe: user.uid ==
                                          listMessage[index].senderId,
                                    ),
                                  ));
                                })
                            : Expanded(
                                child: Center(
                                child: Text(
                                  "Hãy gửi tin nhắn đầu tiên cho người bạn mới",
                                ),
                              )),
                        InputMessage(
                          controller: _messController,
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
