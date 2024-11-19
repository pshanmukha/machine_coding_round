import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_code/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> login({required String email,required String password}) async {
    try {
      debugPrint('before http.post');
      final response = await http.post(
        Uri.parse('${AppConstants.apiUrl}${AppConstants.loginEndpoint}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'user_ip': AppConstants.userIPAddress,
          'os': 'web',
          'user_agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/130.0.0.0 Safari/537.36',
          'browser': 'chrome',
          'portal': 'Attendee'
        }),
      );
      debugPrint('response - $response');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _token = responseData['data']['access_token'];
        debugPrint('_token - $_token');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        notifyListeners();
      } else {
        throw Exception('Login failed');
      }
    } catch (error) {
      debugPrint('Login error: $error');
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return;
    }
    _token = prefs.getString('token');
    notifyListeners();
  }
}