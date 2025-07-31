import 'package:brimo_clone/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegistrationSuccessPage extends StatefulWidget {
  final String userId;
  const RegistrationSuccessPage({super.key, required this.userId});

  @override
  State<RegistrationSuccessPage> createState() => _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // --- FUNGSI NAVIGASI DIPINDAHKAN KE SINI ---
  void _navigateToHome() {
    // Menunggu 6 detik sebelum pindah halaman
    Future.delayed(const Duration(seconds: 6), () {
      // Pastikan widget masih ada di tree sebelum navigasi
      if (mounted) {
        // Gunakan pushAndRemoveUntil untuk menghapus semua halaman sebelumnya (login, registrasi)
        // dan menjadikan halaman utama sebagai halaman pertama.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainScreen(userId: widget.userId),
          ),
              (route) => false, // Hapus semua rute sebelumnya
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/registration_success.json',
              width: 250,
              height: 250,
              repeat: true,
            ),
            const SizedBox(height: 20),
            const Text(
              "Registrasi Berhasil!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00529B),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Selamat bergabung dengan BRImo.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            const Text("Mempersiapkan akun Anda..."),
          ],
        ),
      ),
    );
  }
}