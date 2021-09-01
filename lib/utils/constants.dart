import 'package:flutter/material.dart';

final Color primaryColor = Color(0xffE15B10);
final Color secondaryColor = Color(0xffd6d6d6);

final String amzChatIcon = "assets/image/amz_chat.png";
final String placeholderImage = "assets/image/image-placeholder.jpeg";

final String backIcon = "assets/icons/back.svg";
final String addIcon = "assets/icons/add.svg";
final String cameraIcon = "assets/icons/camera.svg";
final String closeIcon = "assets/icons/close.svg";
final String editIcon = "assets/icons/edit.svg";
final String fileIcon = "assets/icons/file.svg";
final String googleIcon = "assets/icons/google.svg";
final String imageIcon = "assets/icons/image.svg";
final String invisibleIcon = "assets/icons/invisible.svg";
final String optionIcon = "assets/icons/option.svg";
final String searchIcon = "assets/icons/search.svg";
final String sendIcon = "assets/icons/send.svg";
final String signOutIcon = "assets/icons/signout.svg";
final String videoIcon = "assets/icons/video.svg";
final String visibleIcon = "assets/icons/visible.svg";

TextStyle txtRegular(double size, [Color? color]) =>
    TextStyle(fontWeight: FontWeight.w400, fontSize: size, color: color);
TextStyle txtMedium(double size, [Color? color]) =>
    TextStyle(fontWeight: FontWeight.w500, fontSize: size, color: color);
TextStyle txtSemiBold(double size, [Color? color]) =>
    TextStyle(fontWeight: FontWeight.w600, fontSize: size, color: color);
TextStyle txtBold(double size, [Color? color]) =>
    TextStyle(fontWeight: FontWeight.w700, fontSize: size, color: color);
TextStyle txtExtraBold(double size, [Color? color]) =>
    TextStyle(fontWeight: FontWeight.w800, fontSize: size, color: color);
