import 'package:brimo_clone/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Tunggu 7 detik untuk menampilkan animasi
    await Future.delayed(const Duration(seconds: 7));

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    // Navigasi berdasarkan status login
    if (mounted) {
      if (userId != null && userId.isNotEmpty) {
        // Jika ada user_id, langsung ke Halaman Utama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(userId: userId)),
        );
      } else {
        // Jika tidak, ke Login Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00529B),
      body: Center(
        child: Lottie.asset(
            'assets/animations/login_animation.json',
            width: 500
        ),
      ),
    );
  }
}