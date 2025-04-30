import 'package:flutter/material.dart';
import 'package:job_seeker/data/datasource/job_listing_datasource.dart';
import 'package:job_seeker/domain/entity/job_listing_entity.dart';

class JobFilterProvider with ChangeNotifier {
  JobFilterProvider({required this.datasource});

  final JobListingDatasource datasource;
  List<JobListingEntity> _filterJobs = [];
  bool _isLoading = false;
  String? _error;
  String? _selectedJobFilter;

  List<JobListingEntity> get filteredJobs => _filterJobs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setSelectedFilter(String filter) {
    _selectedJobFilter = filter;
    fetchFilterJobs();
    notifyListeners();
  }

  Future<void> fetchFilterJobs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final allJobs = await datasource.fethchALLJobs();
      if (_selectedJobFilter != null && _selectedJobFilter != "All") {
        _filterJobs =
            allJobs.where((job) => job.tags == _selectedJobFilter).toList();
      } else {
        _filterJobs = allJobs;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
