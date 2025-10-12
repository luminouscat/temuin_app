import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temuin_app/models/user.dart';

class AuthRepository {
  final Dio _dio;
  static const String _userKey = 'user_data'; // just as a label

  AuthRepository(this._dio);

  // login
  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'api/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.data['success'] == true) {
        final user = User.fromJson(response.data);
        await _saveUserLocally(user);
        return user;
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      } else {
        throw Exception('Network error. Please check your connection');
      }
    }
  }

  // logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // load saved user
  Future<User?> loadSavedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(_userKey);

      if (userData == null) return null;

      final json = jsonDecode(userData);
      return User.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  // save user locally in shared pref
  Future<void> _saveUserLocally(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }
}
