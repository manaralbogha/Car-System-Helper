import 'package:flutter/material.dart';

class JapaneseScreen extends StatelessWidget {
  const JapaneseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Japanese Screen",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
