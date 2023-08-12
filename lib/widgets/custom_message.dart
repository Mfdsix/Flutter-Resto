import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  final String message;
  final String assetPath;

  const CustomMessage(
      {Key? key, required this.message, required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            height: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(message)
        ],
      ),
    );
  }
}
