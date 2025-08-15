import 'package:flutter/material.dart';
import 'package:job_management_app/models/job_model.dart';
import '../service/api_service.dart';


class JobViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Job> jobs = [];
  bool loading = false;

  Future<void> fetchJobs(String userId, String token) async {
    loading = true; notifyListeners();
    final data = await _apiService.getJobs(userId, token);
    jobs = data.map<Job>((json) => Job.fromJson(json)).toList();
    loading = false; notifyListeners();
  }
}
