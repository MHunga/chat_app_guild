import 'package:chat_app/controllers/message_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class InputMessage extends StatelessWidget {
  InputMessage({
    Key? key,
    required this.controller,
    required this.onTapOption,
    required this.iconOption,
  }) : super(key: key);
  final TextEditingController controller;
  final Function() onTapOption;
  final String iconOption;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTapOption,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(iconOption, width: 24, height: 24),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
              child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 36, maxHeight: 80),
            child: TextField(
              maxLines: 5,
              minLines: 1,
              controller: controller,
              style: txtMedium(16),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Aa",
                hintStyle: txtRegular(16),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                fillColor: secondaryColor.withOpacity(0.5),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
              ),
            ),
          )),
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              if (controller.text.isNotEmpty) {
                context
                    .read<MessageController>()
                    .onSend(mess: controller.text.trim());
                controller.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(sendIcon,
                  width: 24, height: 24, color: primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
