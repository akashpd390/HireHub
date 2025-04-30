import 'package:flutter/material.dart';
import 'package:job_seeker/core/widget/my_custom_icon_button.dart';

class TopChatBarWidget extends StatelessWidget {
  const TopChatBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Connect with\nRecruiters",
            style: TextStyle(
              // color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          MyCustomIconButton(icon: Icons.settings, callback: () {})
        ],
      ),
    );
  }
}
