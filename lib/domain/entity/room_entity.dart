import 'package:job_seeker/domain/entity/recuiter_profile.dart';

class RoomEntity {
  final String id;
  final RecuiterProfile recuiterProfile;

  RoomEntity({required this.id, required this.recuiterProfile});

  factory RoomEntity.fromJson(Map<String, dynamic> json) {
    return RoomEntity(
        id: json["id"],
        recuiterProfile: RecuiterProfile.fromJson(json: json["recuiters"]));
  }
}
