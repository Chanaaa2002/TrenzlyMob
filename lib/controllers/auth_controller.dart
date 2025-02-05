import 'package:dio/dio.dart';
import '../utils/config.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthResult {
  final User? user;      // Holds user data if authentication succeeds
  final String? error;   // Holds error message if authentication fails
  
  AuthResult({this.user, this.error});  // Constructor with named parameters
}

class AuthController {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Config.baseUrl,           // Base URL for all API requests
      connectTimeout: Duration(milliseconds: 5000),  // 5s connection timeout
      receiveTimeout: Duration(milliseconds: 5000),  // 5s receive timeout
      headers: {'Content-Type': 'application/json'}, // Default headers
    ),
  );

  Future<AuthResult> login(String email, String password) async {
    try {
      // Make POST request to login endpoint
      Response response = await _dio.post('/login', data: {
        "email": email,
        "password": password,
      });
      // Check if response is valid

      if (response.statusCode == 200 && response.data != null) {
        var data = response.data;
        User user = User.fromJson(data);// Convert JSON to User object
        await _saveUserSession(user); // Save user session
        return AuthResult(user: user);  // Return success result
      }
      return AuthResult(error: 'Invalid response from server');
    } on DioException catch (e) {
      return AuthResult(error: e.response?.data?['message'] ?? 'Login failed. Please try again.');
    } 
  }

  Future<AuthResult> register(String name, String email, String password) async {
    try {
       // Make POST request to register endpoint
      Response response = await _dio.post('/register', data: {
        "name": name,
        "email": email,
        "password": password,
      });
      // Check if response is valid (201 = Created)
      if (response.statusCode == 201 && response.data != null) {
        var data = response.data;
        User user = User.fromJson(data);
        await _saveUserSession(user);
        return AuthResult(user: user);
      }
      return AuthResult(error: 'Invalid response from server');
    } on DioException catch (e) {
      return AuthResult(error: e.response?.data?['message'] ?? 'Registration failed. Please try again.');
    } catch (e) {
      return AuthResult(error: 'An unexpected error occurred');
    }
  }

  Future<void> _saveUserSession(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();// Get storage instance
      // Validate and save token
      if (user.token != null && user.token!.isNotEmpty) {
        if (user.token != null) {
          await prefs.setString('token', user.token!);
        } else {
          throw Exception('Invalid token');
        }
      }
    } catch (e) {
      throw Exception('Failed to save session');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token'); // Remove stored token
    } catch (e) {
      throw Exception('Failed to logout');
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');  // Check if token exists
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}