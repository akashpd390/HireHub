import 'package:flutter/material.dart';
import 'package:job_seeker/domain/entity/room_entity.dart';
import 'package:job_seeker/prsentation/chat/page/user_chat_screen_page.dart';

class ChatListWidget extends StatelessWidget {
  final RoomEntity roomEntity;

  const ChatListWidget({super.key, required this.roomEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatScreenPage(roomEntity: roomEntity)));
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300)),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomEntity.recuiterProfile.organisation,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  roomEntity.recuiterProfile.name,
                  style: TextStyle(color: Colors.grey.shade600),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
