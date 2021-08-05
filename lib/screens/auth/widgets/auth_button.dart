import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(title),
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
