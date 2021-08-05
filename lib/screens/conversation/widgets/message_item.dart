import 'package:chat_app/repositories/models/message.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.listMessage,
    required this.index,
    required this.isMe,
  }) : super(key: key);

  final List<Message> listMessage;
  final int index;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          //if (!isMe)
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: isMe ? Colors.blue : Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16)),
            child: Text(
              listMessage[index].message ?? "",
              style: TextStyle(
                  fontSize: 16,
                  //  height: 24 / 14,
                  color: isMe ? Colors.white : Colors.black,
                  fontWeight: isMe ? FontWeight.w600 : FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
