import 'package:supabase_flutter/supabase_flutter.dart';

class BookmarksJobsDatasource {
  final SupabaseClient supabase;

  BookmarksJobsDatasource({required this.supabase});

  Future<void> addBookmark(id) async {
    final user = supabase.auth.currentUser;
    try {
      if (user == null) throw Exception("not authenticated");
      await supabase.from('bookmarks').insert({
        "user_id": user.id,
        "job_post_id": id,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeBookmark(id) async {
    final user = supabase.auth.currentUser;
    try {
      if (user == null) throw Exception("not authenticated");
      await supabase
          .from('bookmarks')
          .delete()
          .eq('user_id', user.id)
          .eq('job_post_id', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> fetchBookmarks() async {
    final user = supabase.auth.currentUser;

    try {
      if (user == null) throw Exception("not authenticated");

      final response = await supabase
          .from("bookmarks")
          .select("job_post_id")
          .eq("user_id", user.id);

      return response.map<int>((e) => e["job_post_id"] as int).toList();
    } catch (e) {
      rethrow;
    }
  }
}
