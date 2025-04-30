class MessageEntity {
  final int id;
  final String senderId;
  final String receiverId;
  final String roomId;
  final String content;

  MessageEntity({
    required this.id,
    required this.receiverId,
    required this.roomId,
    required this.senderId,
    required this.content,
  });

  factory MessageEntity.fromJson({required json}) {
    return MessageEntity(
      id: json["id"],
      receiverId: json["reciever_id"],
      roomId: json["room_id"],
      senderId: json["sender_id"],
      content: json["content"],
    );
  }
}
