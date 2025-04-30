import 'package:flutter/material.dart';
import 'package:job_seeker/data/datasource/job_listing_datasource.dart';
import 'package:job_seeker/domain/entity/job_listing_entity.dart';

class JobListingProvider with ChangeNotifier {
  JobListingProvider({required this.datasource});

  final JobListingDatasource datasource;
  List<JobListingEntity> _jobs = [];

  bool _isLoading = false;
  String? _error;

  List<JobListingEntity> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchJobs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jobs = await datasource.fethchALLJobs();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
