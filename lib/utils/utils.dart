import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static String nameInit(String name) {
    List<String> nameSplit = name.split(" ");
    String firstName = "";
    String lastName = "";
    if (nameSplit.length >= 2) {
      firstName = nameSplit[0][0];
      lastName = nameSplit[1][0];
    } else {
      firstName = nameSplit[0][0];
    }

    return firstName + lastName;
  }

  static String timeStamp(Timestamp t) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final duration = now - t.millisecondsSinceEpoch;
    if (duration <= 60000) {
      return "Just now";
    } else {
      final minute = (duration / 60000).floor();
      if (minute < 60) {
        return "$minute min ago";
      } else if (minute >= 60 && minute < 60 * 24) {
        return "${(minute / 60).floor()}h ago";
      } else {
        final date =
            DateTime.fromMillisecondsSinceEpoch(t.millisecondsSinceEpoch);
        return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
      }
    }
  }

  static String userName(String email) {
    String e = email;
    if (email.isNotEmpty) {
      List<String> l = e.split("@");
      return "@${l[0]}";
    } else {
      return "";
    }
  }

  static showPickImageModelBottomSheet(BuildContext context,
      {required Function(File) onPickImage}) {
    ImagePicker imagePicker = ImagePicker();
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 120,
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            ListTile(
              title: Text("From camera"),
              leading: Icon(Icons.camera_alt),
              onTap: () async {
                await imagePicker
                    .pickImage(source: ImageSource.camera)
                    .then((value) {
                  if (value != null) {
                    onPickImage(File(value.path));
                  }
                });
              },
            ),
            ListTile(
              title: Text("From gallery"),
              leading: Icon(Icons.image),
              onTap: () async {
                await imagePicker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) {
                  if (value != null) {
                    onPickImage(File(value.path));
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
