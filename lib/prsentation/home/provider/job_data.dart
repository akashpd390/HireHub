import 'package:flutter/material.dart';

class JobData extends ChangeNotifier {
  List<String> recentJobFilters = [
    'All',
    'Accountant',
    'Programmer',
    'Designer',
    'Management'
  ];
  String selectedRecentJobFilter = 'All';

  void setSelectedRecentJobFilter(String filter) {
    selectedRecentJobFilter = filter;
    notifyListeners();
  }
}
