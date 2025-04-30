import 'package:flutter/material.dart';
import 'package:job_seeker/data/datasource/chat_datasorce.dart';
import 'package:job_seeker/domain/entity/room_entity.dart';

class ChatProvider extends ChangeNotifier {
  final ChatDatasource datasource;

  List<RoomEntity> recuitersList = [];
  String? error;
  bool isLoading = false;

  ChatProvider({required this.datasource});

  Future<void> fetchRecuiterProfile() async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await datasource.fetchUsersConnection();
      recuitersList = data;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
