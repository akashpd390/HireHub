import 'package:flutter/material.dart';
import 'package:job_seeker/data/datasource/user_auth_datasource.dart';
import 'package:job_seeker/domain/entity/user_entity.dart';

class AuthProvider extends ChangeNotifier {
  final UserAuthDataSource dataSource;
  UserEntity? _userEntity;
  bool isLoading = false;
  String? error;

  UserEntity? get user => _userEntity;
  bool get isAuthenticate => _userEntity != null;

  AuthProvider({required this.dataSource}) {
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await dataSource.getCurrentUser();
      if (data != null) {
        _userEntity = data;
      } else {
        _userEntity = null;
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // creating a profile
  Future<void> createProfile(UserEntity usrParams) async {
    isLoading = true;
    notifyListeners();
    try {
      final usr = await dataSource.ragisterUsrProfile(usrParams);
      _userEntity = usr;
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Sign in user
  Future<void> sigIn(email, password) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await dataSource.signIn(email, password);
      _userEntity = data;
      print(_userEntity);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Sign up user
  Future<void> sigUp(email, password) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await dataSource.signUp(email, password);
      if (data == null) {
        throw Exception("Ragisteration Failed");
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch current session
  Future<void> currentSession() async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await dataSource.getCurrentUser();
      if (data != null) {
        _userEntity = data;
      } else {
        _userEntity = null; // Only set to null if no user is found
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Sign out user
  Future<void> signOut() async {
    isLoading = true;
    notifyListeners();
    try {
      await dataSource.signOut();
      _userEntity = null; // Nullify the user entity after sign out
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
