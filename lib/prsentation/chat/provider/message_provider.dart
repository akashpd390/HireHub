import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_seeker/data/datasource/chat_datasorce.dart';
import 'package:job_seeker/domain/entity/message_entity.dart';

class MessageProvider extends ChangeNotifier {
  final ChatDatasource datasource;

  List<MessageEntity> messages = [];
  bool isLoading = false;
  String? error;

  StreamSubscription<MessageEntity>? _subscription;

  MessageProvider({required this.datasource});

  Future<void> fetchMessages(String roomId) async {
    isLoading = true;
    notifyListeners();
    try {
      messages = await datasource.fetchMessages(roomId: roomId);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage({
    required String content,
    required String receiverId,
    required String roomId,
  }) async {
    await datasource.sendMessage(
      content: content,
      receiverId: receiverId,
      roomId: roomId,
    );
  }

  void subscribeToMessages(String roomId) {
    _subscription?.cancel(); // cancel old stream if exists
    _subscription = datasource.subscribeToMessages(roomId).listen((newMessage) {
      final alreadyExists = messages.any((msg) => msg.id == newMessage.id);
      if (!alreadyExists) {
        messages.add(newMessage);
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
