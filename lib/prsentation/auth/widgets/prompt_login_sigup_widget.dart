import 'package:flutter/material.dart';

class PromptLoginSignUpWidget extends StatelessWidget {
  final String text;
  final String promptText;
  final VoidCallback onPressed;

  const PromptLoginSignUpWidget({
    super.key,
    required this.text,
    required this.promptText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              promptText,
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  }
}
