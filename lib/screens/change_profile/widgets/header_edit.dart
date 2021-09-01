import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderEdit extends StatelessWidget {
  const HeaderEdit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(backIcon,
                width: 30, height: 30, color: primaryColor),
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            "Edit profile",
            style: txtSemiBold(18),
          )
        ],
      ),
    );
  }
}
