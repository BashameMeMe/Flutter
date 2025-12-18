import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/BaiTap/BaiTap9/Bai9part2.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> login() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final url = Uri.parse("https://dummyjson.com/auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": usernameController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(
            userData: data,
            accessToken: data["accessToken"],
            refreshToken: data["refreshToken"],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Login failed")),
      );
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          // ===== BACKGROUND =====
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // ===== LOGIN FORM =====
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 14,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Avatar
                      Hero(
                        tag: "avatar",
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: const Icon(
                            Icons.person,
                            size: 48,
                            color: Color(0xFF6A1B9A),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        "Welcome Back 👋",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Login to continue",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                      const SizedBox(height: 28),

                      // Username
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person_outline),
                          labelText: "Username",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Password
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.lock_outline),
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Login Button
                      GestureDetector(
                        onTap: _isLoading ? null : login,
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 200),
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(16),
                            gradient:
                                const LinearGradient(
                              colors: [
                                Color(0xFF6A1B9A),
                                Color(0xFF8E24AA),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple
                                    .withOpacity(0.4),
                                blurRadius: 10,
                                offset:
                                    const Offset(0, 6),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}