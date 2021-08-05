import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/controllers/%08search_controller.dart';
import 'package:chat_app/screens/conversation/conversation_screen.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewConversationScreen extends StatefulWidget {
  const NewConversationScreen({Key? key}) : super(key: key);

  @override
  _NewConversationScreenState createState() => _NewConversationScreenState();
}

class _NewConversationScreenState extends State<NewConversationScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthController>().appUser;
    return ChangeNotifierProvider<SearchController>(
        create: (_) => SearchController(user!.uid!),
        builder: (context, child) {
          final controller = context.watch<SearchController>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              bottom: PreferredSize(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        autofocus: true,
                        onChanged: (val) {
                          context.read<SearchController>().searchUser(val);
                        },
                        decoration: InputDecoration(
                            hintText: "Tìm kiếm",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    Divider(),
                  ],
                ),
                preferredSize: Size(double.infinity, 40),
              ),
            ),
            body: ListView.builder(
              itemCount: controller.listSearchUser.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.6),
                  backgroundImage: controller.listSearchUser[index].photoUrl !=
                          null
                      ? NetworkImage(controller.listSearchUser[index].photoUrl!)
                      : null,
                  child: controller.listSearchUser[index].photoUrl != null
                      ? null
                      : Text(
                          Utils.nameInit(
                              controller.listSearchUser[index].displayName ??
                                  ""),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                ),
                title: Text(
                  controller.listSearchUser[index].displayName ?? "",
                ),
                subtitle: Text(
                  controller.listSearchUser[index].email ?? "",
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ConversationScreen(
                              receiver: controller.listSearchUser[index])));
                },
              ),
            ),
          );
        });
  }
}
