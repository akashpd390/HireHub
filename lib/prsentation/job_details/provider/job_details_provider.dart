import 'package:flutter/foundation.dart';
import 'package:job_seeker/data/datasource/job_listing_datasource.dart';
import 'package:job_seeker/domain/entity/job_listing_entity.dart';

class JobDetailsProvider extends ChangeNotifier {
  JobDetailsProvider({required this.datasource});

  final JobListingDatasource datasource;
  JobListingEntity? _job;

  bool _isLoading = false;
  String? _error;

  JobListingEntity? get job => _job;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchJob(id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _job = await datasource.fethchJobById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> applyJobs(id, resumeUrl) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await datasource.applyJobs(id, resumeUrl);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
