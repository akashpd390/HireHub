import 'package:job_seeker/domain/entity/message_entity.dart';
import 'package:job_seeker/domain/entity/room_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatDatasource {
  final SupabaseClient supabase;

  ChatDatasource({required this.supabase});

  Future<List<RoomEntity>> fetchUsersConnection() async {
    final user = supabase.auth.currentUser;

    try {
      if (user == null) throw Exception("user not authenticated");

      final response = await supabase
          .from("room")
          .select("id, recuiters(*)")
          .eq("user_id", user.id);

      return response.map((e) => RoomEntity.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch messages by room ID
  Future<List<MessageEntity>> fetchMessages({required String roomId}) async {
    final response = await supabase
        .from("messages")
        .select()
        .eq("room_id", roomId)
        .order("created_at", ascending: true);

    return response.map((json) => MessageEntity.fromJson(json: json)).toList();
  }

  Future<void> sendMessage({
    required String content,
    required String receiverId,
    required String roomId,
  }) async {
    final senderId = supabase.auth.currentUser!.id;
    await supabase.from("messages").insert({
      "content": content,
      "sender_id": senderId,
      "reciever_id": receiverId,
      "room_id": roomId,
    });
  }

  // Real-time stream of messages in a room
  Stream<MessageEntity> subscribeToMessages(String roomId) {
    return supabase
        .from("messages")
        .stream(primaryKey: ['id'])
        .eq("room_id", roomId)
        .order("created_at")
        .map((event) =>
            event.map((json) => MessageEntity.fromJson(json: json)).toList())
        .expand((list) => list); // flatten list to single message stream
  }
}
