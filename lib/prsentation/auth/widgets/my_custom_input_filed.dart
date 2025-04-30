import 'package:flutter/material.dart';

class MyCustomInputFiled extends StatefulWidget {
  final TextEditingController textEditingController;
  final String text;
  final bool isPassword;
  const MyCustomInputFiled({
    super.key,
    required this.text,
    this.isPassword = false,
    required this.textEditingController,
  });

  @override
  State<MyCustomInputFiled> createState() => _MyCustomInputFiledState();
}

class _MyCustomInputFiledState extends State<MyCustomInputFiled> {
  bool isPasswordHidden = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TextField(
        obscureText: isPasswordHidden,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: isPasswordHidden
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility))
                : null),
      ),
    );
  }
}
