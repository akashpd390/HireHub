import 'package:flutter/material.dart';

class MyCustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback callback;

  const MyCustomIconButton(
      {super.key, required this.icon, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: IconButton(
        icon: Icon(
          icon,
        ),
        onPressed: callback,
      ),
    );
  }
}
