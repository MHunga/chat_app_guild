import 'package:chat_app/controllers/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputMessage extends StatelessWidget {
  InputMessage({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -4), blurRadius: 8)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 46, maxHeight: 80),
                child: TextField(
                  maxLines: 5,
                  minLines: 1,
                  controller: controller,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Nhập tin nhắn",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    fillColor: Colors.grey.withOpacity(0.6),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none),
                  ),
                ),
              )),
              SizedBox(
                width: 4,
              ),
              IconButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context
                          .read<MessageController>()
                          .onSend(mess: controller.text.trim());
                      controller.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send_rounded,
                    color: Colors.deepOrange,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
