import 'package:flutter/material.dart';
import '../service/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? userId;
  String? token;
  bool isLoading = false;
  String? error;

Future<bool> login(String username, String password) async {
  isLoading = true;
  error = null;
  notifyListeners();

  try {
    final response = await _apiService.login(username, password);

    if (response['status'] == 200 && response['data'] != null) {
      userId = response['data']['user_id'];
      token = response['data']['token'];

      isLoading = false;
      notifyListeners();
      return true;
    } else {
      error = response['message'] ?? "Login failed.";
      isLoading = false;
      notifyListeners();
      return false;
    }
  } catch (e) {
    error = "An error occurred: $e";
    isLoading = false;
    notifyListeners();
    return false;
  }
}


}
