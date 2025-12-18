import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const baseUrl = "https://dummyjson.com";

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception("Login failed");
    }

    final data = jsonDecode(res.body);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("accessToken", data["accessToken"]);
    await prefs.setString("refreshToken", data["refreshToken"]);

    return data;
  }

  static Future<String?> refreshAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("refreshToken");
    if (refreshToken == null) return null;

    final res = await http.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await prefs.setString("accessToken", data["accessToken"]);
      return data["accessToken"];
    }
    return null;
  }
}
