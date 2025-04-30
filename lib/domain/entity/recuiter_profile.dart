class RecuiterProfile {
  final String id;
  final String name;
  final String email;
  final String organisation;
  final String? avatar;
  final String location;
  final String? description;

  RecuiterProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.organisation,
    required this.avatar,
    required this.description,
    required this.location,
  });

  factory RecuiterProfile.fromJson({required json}) {
    return RecuiterProfile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        organisation: json["organisation"],
        avatar: json["avatar"],
        description: json["description"],
        location: json["location"]);
  }
}
