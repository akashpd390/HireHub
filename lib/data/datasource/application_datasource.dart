import 'package:job_seeker/domain/entity/applications_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApplicationDatasource {
  final SupabaseClient supabase;

  ApplicationDatasource({required this.supabase});

  Future<List<ApplicationEntity>> fetchApplications() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("user not authenticated");
      final respose = await supabase
          .from("applications")
          .select(
              "id,status, job_post_id ,created_at, JobList(job_title, company_name, image)")
          .eq("usr_id", user.id);

      return respose.map((e) {
        return ApplicationEntity.fromJson(e);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ApplicationStatusEntity>> subscribeToApplication() {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("user not authenticated");

    return supabase
        .from("applications")
        .stream(primaryKey: ['id'])
        .eq("usr_id", user.id)
        .map(
          (event) {
            return event.map((json) {
              return ApplicationStatusEntity.fromJson(json);
            }).toList();
          },
        );
  }
}
