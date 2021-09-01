import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/header_search.dart';
import 'widgets/search_result_item.dart';

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
            body: SafeArea(
              child: Column(
                children: [
                  HeaderSearch(),
                  Expanded(
                    child: controller.listSearchUser.length > 0
                        ? ListView.builder(
                            itemCount: controller.listSearchUser.length,
                            itemBuilder: (context, index) =>
                                SearchResultUserItem(
                                    appUser: controller.listSearchUser[index]),
                          )
                        : ListView.builder(
                            itemCount: controller.listAllUser.length,
                            itemBuilder: (context, index) =>
                                SearchResultUserItem(
                                    appUser: controller.listAllUser[index]),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
