import 'package:flutter/material.dart';

class AuthTextInput extends StatelessWidget {
  const AuthTextInput(
      {Key? key,
      required this.controller,
      required this.lableText,
      required this.keyboardType,
      this.obscure = false})
      : super(key: key);

  final TextEditingController controller;
  final String lableText;
  final TextInputType keyboardType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          labelText: lableText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: Colors.grey.shade400))),
    );
  }
}
