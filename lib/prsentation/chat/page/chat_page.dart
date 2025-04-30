import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/chat/provider/chat_provider.dart';
import 'package:job_seeker/prsentation/chat/widget/chat_list_widget.dart';
import 'package:job_seeker/prsentation/chat/widget/top_chat_bar_widget.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<ChatProvider>().fetchRecuiterProfile());
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          // Header Text
          const TopChatBarWidget(),
          // const SizedBox(height: 20),

          // Chat List Section
          if (chatProvider.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (chatProvider.recuitersList.isEmpty)
            const Text("No chats found.")
          else
            Column(
              children: chatProvider.recuitersList
                  .map((e) => ChatListWidget(
                        roomEntity: e,
                      ))
                  .toList(),
            )
        ],
      ),
    );
  }
}
