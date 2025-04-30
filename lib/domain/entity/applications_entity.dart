enum ApplicationStatus {
  applied,
  shortlisted,
  interviewed,
  hired,
  rejected,
}

class ApplicationStatusEntity {
  final int id;
  final ApplicationStatus status;

  ApplicationStatusEntity({
    required this.id,
    required this.status,
  });
  factory ApplicationStatusEntity.fromJson(Map<String, dynamic> json) {
    return ApplicationStatusEntity(
      id: json['id'],
      status: _statusFromString(json['status'] as String),
    );
  }
  static ApplicationStatus _statusFromString(String value) {
    return ApplicationStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ApplicationStatus.applied, // Default fallback
    );
  }
}

class JobList {
  final String? image;
  final String jobTitle;
  final String? companyName;

  JobList({
    this.image,
    required this.jobTitle,
    required this.companyName,
  });

  factory JobList.fromJson(Map<String, dynamic> json) {
    return JobList(
      image: json['image'].isEmpty
          ? 'https://bbekokmtumrrmjbohsdv.supabase.co/storage/v1/object/public/profiles//microsoft_PNG13.webp'
          : json['image'],
      jobTitle: json['job_title'],
      companyName: json['company_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'job_title': jobTitle,
      'company_name': companyName,
    };
  }
}

class ApplicationEntity {
  final int id;
  final int jobId;
  final ApplicationStatus status;
  final JobList job;
  final String createdAt;

  ApplicationEntity(
      {required this.id,
      required this.jobId,
      required this.status,
      required this.createdAt,
      required this.job});

  // Factory method to create from JSON
  factory ApplicationEntity.fromJson(Map<String, dynamic> json) {
    return ApplicationEntity(
      id: json['id'],
      jobId: json['job_post_id'],
      status: _statusFromString(json['status'] as String),
      createdAt: json["created_at"],
      job: JobList.fromJson(json['JobList']),
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_post_id': jobId,
      'status': status.name, // Dart 2.15+ for .name
      'JobList': job.toJson(),
    };
  }

  ApplicationEntity copyWith({
    int? id,
    int? jobId,
    ApplicationStatus? status,
    String? createdAt,
    JobList? job,
  }) {
    return ApplicationEntity(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      job: job ?? this.job,
    );
  }

  // Helper function to convert string to enum
  static ApplicationStatus _statusFromString(String value) {
    return ApplicationStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ApplicationStatus.applied, // Default fallback
    );
  }
}
