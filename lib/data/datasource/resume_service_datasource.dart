import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResumeServiceDatasource {
  final SupabaseClient supabase;

  ResumeServiceDatasource({required this.supabase});

  Future<String?> uploadResume(File file, String fileName) async {
    // Pick a file

    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("user no logged in");
    final uniquevalue = DateTime.now().microsecond;
    final filePath = 'resumes/${user.id}/$uniquevalue$fileName';

    // Upload to Supabase bucket
    await supabase.storage
        .from('resumes') // 👈 your bucket name
        .upload(filePath, file,
            fileOptions: const FileOptions(
              upsert: false,
            ));

    // Return the public URL
    final publicUrl = supabase.storage.from('resumes').getPublicUrl(filePath);
    updateResumeUrlProfile(publicUrl, user.id);

    return publicUrl;
  }

  Future<void> updateResumeUrlProfile(String publicUrl, userId) async {
    try {
      await supabase
          .from("profiles")
          .update({
            "resume_url": publicUrl,
          })
          .eq("id", userId)
          .select()
          .single();
    } catch (e) {
      rethrow;
    }
  }
}
