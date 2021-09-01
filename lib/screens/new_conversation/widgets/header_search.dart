import 'package:chat_app/controllers/search_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({
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
          Expanded(
              child: TextField(
            style: TextStyle(fontSize: 20),
            autofocus: true,
            onChanged: (val) {
              context.read<SearchController>().searchUser(val);
            },
            decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
                border: UnderlineInputBorder(borderSide: BorderSide.none)),
          ))
        ],
      ),
    );
  }
}
