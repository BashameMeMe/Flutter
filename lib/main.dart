import 'package:flutter/material.dart';

// ===== IMPORT BÀI TẬP CỦA BẠN =====
import 'package:flutter_application_1/BaiTap/BaiTap1/Bai1.dart';
import 'package:flutter_application_1/BaiTap/BaiTap2/bai2.dart';
import 'package:flutter_application_1/BaiTap/BaiTap3/bai3.dart';
import 'package:flutter_application_1/BaiTap/BaiTap4/bai4part1.dart';
import 'package:flutter_application_1/BaiTap/BaiTap4/bai4part2.dart';
import 'package:flutter_application_1/BaiTap/BaiTap4/bai4part3.dart';
import 'package:flutter_application_1/BaiTap/BaiTap5/Bai5part1.dart';
import 'package:flutter_application_1/BaiTap/BaiTap5/Bai5part2.dart';
import 'package:flutter_application_1/BaiTap/BaiTap6/bai6part1.dart';
import 'package:flutter_application_1/BaiTap/BaiTap6/bai6part2.dart';
import 'package:flutter_application_1/BaiTap/BaiTap7/my_product.dart';
import 'package:flutter_application_1/BaiTap/BaiTap8/bai8part1.dart';
import 'package:flutter_application_1/BaiTap/BaiTap9/Bai9part1.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: MainMenuPage(
        isDarkMode: isDarkMode,
        onToggleTheme: () {
          setState(() => isDarkMode = !isDarkMode);
        },
      ),
    );
  }
}

class MainMenuPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const MainMenuPage({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int currentIndex = 0;

  late final List<List<MenuItem>> pages = [
    [
      MenuItem('Bài 1', Icons.school, const CourseApp()),
      MenuItem('Bài 2', Icons.flight, const TravelApp()),
      MenuItem('Bài 3', Icons.home, const HomeScreen()),
      MenuItem('Change Color', Icons.color_lens, const ChangeColorApp()),
      MenuItem('Counter', Icons.add_circle, const CounterApp()),
      MenuItem('Countdown', Icons.timer, const CountdownTimerScreen()),
    ],
    [
      MenuItem('Register', Icons.app_registration, const RegisterFormScreen()),
      MenuItem('Login', Icons.login, const LoginFormScreen()),
      MenuItem('BMI', Icons.monitor_weight, const BMIPage()),
      MenuItem('Feedback', Icons.feedback, const FeedbackPage()),
    ],
    [
      MenuItem('Product', Icons.shopping_bag, const MyProductPage()),
      MenuItem('News', Icons.newspaper, const NewsList()),
      MenuItem('Login UI', Icons.lock, const LoginPage()),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final items = pages[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Exercise Hub',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return AnimatedMenuCard(item: items[index]);
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Cơ bản'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Form'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'App'),
        ],
      ),
    );
  }
}

class AnimatedMenuCard extends StatefulWidget {
  final MenuItem item;
  const AnimatedMenuCard({super.key, required this.item});

  @override
  State<AnimatedMenuCard> createState() => _AnimatedMenuCardState();
}

class _AnimatedMenuCardState extends State<AnimatedMenuCard> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.95),
      onTapUp: (_) => setState(() => scale = 1),
      onTapCancel: () => setState(() => scale = 1),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HeroWrapperPage(item: widget.item),
          ),
        );
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.item.title,
                child: Icon(
                  widget.item.icon,
                  size: 42,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class HeroWrapperPage extends StatelessWidget {
  final MenuItem item;
  const HeroWrapperPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // HERO ICON (NHỎ LẠI)
          Hero(
            tag: item.title,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                size: 48, // ✅ GIẢM TỪ 100 → 48
                color: Colors.deepPurple,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // TITLE NHỎ GỌN
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16, // ✅ GIẢM TỪ 22 → 16
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          // CONTENT
          Expanded(
            child: item.page,
          ),
        ],
      ),
    );
  }
}


class MenuItem {
  final String title;
  final IconData icon;
  final Widget page;

  MenuItem(this.title, this.icon, this.page);
}
