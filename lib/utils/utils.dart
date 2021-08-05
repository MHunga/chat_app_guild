import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
}
