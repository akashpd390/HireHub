class JobListingEntity {
  final int id;
  final String createdAt;
  final String jobTitle;
  final String jobDesc;
  final String type;
  final String companyName;
  final String location;
  final String profilePic;
  final String salary;
  final String workingModel;
  final String level;
  final String tags;
  final String image;

  JobListingEntity({
    required this.id,
    required this.createdAt,
    required this.jobTitle,
    required this.jobDesc,
    required this.type,
    required this.companyName,
    required this.location,
    required this.profilePic,
    required this.salary,
    required this.level,
    required this.workingModel,
    required this.tags,
    required this.image,
  });

  // Factory method to convert JSON into a JobListing object
  factory JobListingEntity.fromJson(Map<String, dynamic> json) {
    return JobListingEntity(
      id: json['id'],
      createdAt: json['created_at'],
      jobTitle: json['job_title'],
      jobDesc: json['job_desc'],
      type: json['type'],
      companyName: json['company_name'],
      location: json['location'],
      profilePic: json['profile_pic'] ?? '', // handle null case
      salary: json['salary'],
      level: json['level'],
      workingModel: json['working_model'],
      tags: json['tags'],
      image: json['image'].isNotEmpty
          ? json['image']
          : 'https://bbekokmtumrrmjbohsdv.supabase.co/storage/v1/object/public/profiles//microsoft_PNG13.webp', // default image URL
    );
  }

  // Method to convert a JobListing object into JSON (useful for inserting data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'job_title': jobTitle,
      'job_desc': jobDesc,
      'type': type,
      'company_name': companyName,
      'location': location,
      'profile_pic': profilePic,
      'salary': salary,
      'working_model': workingModel,
      'level': level,
      'tags': tags,
      'image': image,
    };
  }
}
