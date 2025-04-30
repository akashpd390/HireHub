import 'package:flutter/material.dart';
import 'package:job_seeker/domain/entity/message_entity.dart';
import 'package:job_seeker/domain/entity/room_entity.dart';
import 'package:job_seeker/prsentation/auth/widgets/my_custom_input_filed.dart';
import 'package:job_seeker/prsentation/chat/provider/message_provider.dart';
import 'package:provider/provider.dart';

class ChatScreenPage extends StatefulWidget {
  final RoomEntity roomEntity;

  const ChatScreenPage({super.key, required this.roomEntity});

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final messageProvider = context.read<MessageProvider>();
    final roomId = widget.roomEntity.id;

    // Fetch existing messages
    messageProvider.fetchMessages(roomId);

    // Start listening for new incoming messages
    messageProvider.subscribeToMessages(roomId);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    context.read<MessageProvider>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider = context.watch<MessageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.roomEntity.recuiterProfile.organisation),
            Text(widget.roomEntity.recuiterProfile.name,
                style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messageProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildMessageList(messageProvider.messages),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(List<MessageEntity> messages) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[messages.length - 1 - index]; // reverse order
        final isMine = msg.senderId !=
            widget.roomEntity.recuiterProfile.id; // change logic if needed

        return Align(
          alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: isMine ? Colors.purple[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(msg.content),
          ),
        );
      },
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300)),
              child: MyCustomInputFiled(
                text: "Send a message",
                textEditingController: textEditingController,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              final content = textEditingController.text.trim();
              if (content.isNotEmpty) {
                final messageProvider = context.read<MessageProvider>();
                messageProvider.sendMessage(
                  content: content,
                  receiverId: widget.roomEntity.recuiterProfile.id,
                  roomId: widget.roomEntity.id,
                );
                textEditingController.clear();
              }
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
