import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:job_seeker/data/datasource/application_datasource.dart';
import 'package:job_seeker/domain/entity/applications_entity.dart';

class ApplicationProvider extends ChangeNotifier {
  List<ApplicationEntity> applications = [];
  bool isLoading = false;
  String? error;
  ApplicationDatasource datasource;
  ApplicationProvider({required this.datasource});
  StreamSubscription<List<ApplicationStatusEntity>>? _subscription;

  Future<void> fetchApplication() async {
    isLoading = true;
    notifyListeners();
    try {
      applications = await datasource.fetchApplications();
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void subscribeToApplication() {
    _subscription?.cancel(); // cancel old stream if exists

    _subscription =
        datasource.subscribeToApplication().listen((newApplication) {
      for (var newApp in newApplication) {
        int index =
            applications.indexWhere((element) => element.id == newApp.id);
        if (index != -1) {
          applications[index] =
              applications[index].copyWith(status: newApp.status);
        }
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel(); // cancel the stream subscription
    super.dispose();
  }
}
