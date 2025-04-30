class UserEntity {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String resumeUrl;
  final String lastName;
  final String phoneNo;
  final String address;
  final String dateOfBirth;
  final String jobProfile;
  final String skills;

  // Constructor
  UserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.skills,
      required this.lastName,
      required this.address,
      required this.avatar,
      required this.resumeUrl,
      required this.dateOfBirth,
      required this.jobProfile,
      required this.phoneNo});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json["id"],
      name: json["first_name"],
      email: json["email"],
      skills: json["skills"],
      jobProfile: json["job_profile"],
      address: json["address"],
      avatar: json["avatar"],
      dateOfBirth: json["date_of_birth"],
      lastName: json["last_name"],
      resumeUrl: json["resume_url"],
      phoneNo: json["phone_no"],
    );
  }

  // Method to convert a JobListing object into JSON (useful for inserting data)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": name,
      "email": email,
      "skills": skills,
      "job_profile": jobProfile,
      "address": address,
      "avatar": avatar,
      "date_of_birth": dateOfBirth,
      "last_name": lastName,
      "resume_url": resumeUrl,
      "phone_no": phoneNo,
    };
  }

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? skills,
    String? jobProfile,
    String? address,
    String? avatar,
    String? dateOfBirth,
    String? lastName,
    String? resumeUrl,
    String? phoneNo,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      skills: skills ?? this.skills,
      jobProfile: jobProfile ?? this.jobProfile,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      lastName: lastName ?? this.lastName,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }
}
