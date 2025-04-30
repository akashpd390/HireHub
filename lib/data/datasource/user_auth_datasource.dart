import 'package:job_seeker/domain/entity/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuthDataSource {
  final SupabaseClient supabase;

  UserAuthDataSource({required this.supabase});

  Future<String?> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response.user?.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserEntity> ragisterUsrProfile(UserEntity usrParams) async {
    try {
      await supabase.auth.refreshSession();

      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception("Usr not found");
      }
      final data = usrParams.copyWith(id: user.id, email: user.email).toJson();
      await supabase.from("profiles").insert([data]);

      return _usrEntity(user.id);
    } catch (e) {
      throw Exception("error creating a profile");
    }
  }

  Future<UserEntity> _usrEntity(id) async {
    try {
      final data =
          await supabase.from("profiles").select().eq("id", id).single();
      print(data);
      return UserEntity.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  // Login user
  Future<UserEntity> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return _usrEntity(response.user!.id);
    } catch (e) {
      rethrow;
    }
  }

  // Logout user
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      // TODO: cath statement
    }
  }

  // Get current user
  Future<UserEntity?> getCurrentUser() async {
    try {
      // Ensure Supabase restores session state
      await supabase.auth.refreshSession();

      final user = supabase.auth.currentUser;
      if (user == null) return null;

      var data =
          await supabase.from("profiles").select().eq("id", user.id).single();

      return UserEntity.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  // Check if user is authenticated
  bool isAuthenticated() {
    return supabase.auth.currentSession != null;
  }

  // Reset Password
}
