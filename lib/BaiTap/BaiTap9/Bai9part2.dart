import 'package:flutter/material.dart';
import 'package:flutter_application_1/BaiTap/BaiTap9/Bai9part1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String accessToken;
  final String refreshToken;

  const ProfilePage({
    super.key,
    required this.userData,
    required this.accessToken,
    required this.refreshToken,
  });

  // 1 dòng thông tin
  Widget infoRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value?.toString() ?? "N/A",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  // Section đẹp hơn (icon + màu)
  Widget section({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.remove("refreshToken");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== AVATAR =====
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.indigo, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                  userData["image"] ??
                      "https://via.placeholder.com/150",
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              userData["username"] ?? "",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userData["email"] ?? "",
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 24),

            // ===== PERSONAL INFO =====
            section(
              title: "Personal Information",
              icon: Icons.person,
              children: [
                infoRow("ID", userData["id"]),
                infoRow("First Name", userData["firstName"]),
                infoRow("Last Name", userData["lastName"]),
                infoRow("Age", userData["age"]),
                infoRow("Gender", userData["gender"]),
                infoRow("Birth Date", userData["birthDate"]),
                infoRow("Phone", userData["phone"]),
              ],
            ),

            // ===== HAIR =====
            section(
              title: "Hair",
              icon: Icons.brush,
              children: [
                infoRow("Color", userData["hair"]?["color"]),
                infoRow("Type", userData["hair"]?["type"]),
              ],
            ),

            // ===== ADDRESS =====
            section(
              title: "Address",
              icon: Icons.location_on,
              children: [
                infoRow("City", userData["address"]?["city"]),
                infoRow("Country", userData["address"]?["country"]),
                infoRow("Address", userData["address"]?["address"]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
