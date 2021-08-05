import 'package:flutter/material.dart';

class CircularProgressFullScreen extends StatelessWidget {
  const CircularProgressFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
