import 'dart:io';

import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/screens/auth/widgets/auth_button.dart';
import 'package:chat_app/screens/auth/widgets/full_screen_circular_progress.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({Key? key}) : super(key: key);

  @override
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  File? avatarImage;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController nameController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: context.read<AuthController>().appUser!.displayName);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().appUser;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Đổi thông tin"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    _showModelBottomSheet();
                  },
                  child: avatarImage != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(avatarImage!),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.withOpacity(0.6),
                          backgroundImage: user!.photoUrl != null
                              ? NetworkImage(user.photoUrl!)
                              : null,
                          child: user.photoUrl != null
                              ? null
                              : Text(Utils.nameInit(user.displayName ?? ""),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                        ),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: "Tên",
                      suffixIcon: Icon(Icons.edit),
                      prefixIcon: SizedBox(width: 24),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
                SizedBox(
                  height: 24,
                ),
                AuthButton(
                    title: "Cập nhật",
                    onTap: () async {
                      await context
                          .read<AuthController>()
                          .updateUser(
                              displayName: nameController.text,
                              avatar: avatarImage)
                          .then((value) {
                        if (value) {
                          Navigator.pop(context);
                        }
                      });
                    })
              ],
            ),
          ),
        ),
        if (context.watch<AuthController>().isLoading)
          CircularProgressFullScreen()
      ],
    );
  }

  void _showModelBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 120,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              title: Text("Chụp từ camera"),
              leading: Icon(Icons.camera_alt),
              onTap: () async {
                await _picker
                    .pickImage(source: ImageSource.camera)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      avatarImage = File(value.path);
                      Navigator.pop(context);
                    });
                  }
                });
              },
            ),
            ListTile(
              title: Text("Chọn từ thư viện"),
              leading: Icon(Icons.image),
              onTap: () async {
                await _picker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      avatarImage = File(value.path);
                      Navigator.pop(context);
                    });
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
