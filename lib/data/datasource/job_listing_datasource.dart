import 'package:job_seeker/domain/entity/job_listing_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JobListingDatasource {
  final SupabaseClient _supabaseClient;

  JobListingDatasource({required supabaseClient})
      : _supabaseClient = supabaseClient;

  Future<List<JobListingEntity>> fethchALLJobs() async {
    final data = await _supabaseClient.from("JobList").select();
    // print(data);

    return data.map((e) => JobListingEntity.fromJson(e)).toList();
  }

  Future<JobListingEntity> fethchJobById(int id) async {
    final data =
        await _supabaseClient.from("JobList").select().eq('id', id).single();

    return JobListingEntity.fromJson(data);
  }

  /// Apply for jobs
  Future<void> applyJobs(jobPostId, resumeUrl) async {
    try {
      final usrId = _supabaseClient.auth.currentUser;
      if (usrId == null) {
        throw Exception("usr not authenticated");
      }

      await _supabaseClient.from("applications").insert({
        "usr_id": usrId.id,
        "job_post_id": jobPostId,
        "resume_url": resumeUrl
      });
    } catch (e) {
      rethrow;
    }
  }
}
