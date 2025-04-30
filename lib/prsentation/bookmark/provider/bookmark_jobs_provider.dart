import 'package:flutter/material.dart';
import 'package:job_seeker/data/datasource/bookmark_jobs_datasource.dart';

class BookMarkJobProvider with ChangeNotifier {
  BookMarkJobProvider({required datasource}) : _datasource = datasource;

  final BookmarksJobsDatasource _datasource;

  List<int> _jobs = [];

  bool _isLoading = false;
  String? _error;

  List<int> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBookMarkJobs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jobs = await _datasource.fetchBookmarks();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleBookmark(int id) async {
    try {
      if (_jobs.contains(id)) {
        _jobs.remove(id);
        notifyListeners();
        await _datasource.removeBookmark(id);
      } else {
        _jobs.add(id);
        notifyListeners();
        await _datasource.addBookmark(id);
      }
    } catch (e) {
      _error = e.toString();
    }
  }
}
