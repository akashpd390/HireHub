import 'package:flutter/material.dart';
import 'package:job_seeker/core/widget/my_custom_icon_button.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search anything',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        MyCustomIconButton(icon: Icons.tune, callback: () {})
      ],
    );
  }
}
