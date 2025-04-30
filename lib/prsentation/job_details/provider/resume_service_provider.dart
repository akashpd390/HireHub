import 'dart:io';
import 'package:flutter/material.dart';
import 'package:job_seeker/data/datasource/resume_service_datasource.dart';

class ResumeProvider extends ChangeNotifier {
  bool isUploading = false;
  String? resumeUrl;

  final ResumeServiceDatasource datasource;

  ResumeProvider({required this.datasource});

  Future<String> uploadResume(File file, String fileName) async {
    isUploading = true;
    notifyListeners();
    try {
      final String? resumeUrl = await datasource.uploadResume(file, fileName);
      if (resumeUrl == null) {
        throw Exception("Failed to upload resume");
      }
      return resumeUrl;
    } catch (e) {
      rethrow;
    } finally {
      isUploading = false;
      notifyListeners();
    }
  }
}
