import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/datasource/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService apiService;
  bool _isAuthenticated = false;

  AuthProvider({required this.apiService});

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    String result = await apiService.loginAdmin(email, password);
    if (result == 'Login successful') {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await apiService.clearTokens();
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.containsKey('accessToken');
    notifyListeners();
  }
}
