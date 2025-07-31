import 'package:brimo_clone/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BukaRekeningSuccessPage extends StatelessWidget {
  final String productName;
  final String newAccountNumber;
  final String userId;

  const BukaRekeningSuccessPage({
    super.key,
    required this.productName,
    required this.newAccountNumber,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/success.json', // Pastikan path ini benar
              width: 250,
              height: 250,
              repeat: false,
            ),
            const SizedBox(height: 20),
            Text(
              "Pembukaan Rekening Berhasil!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Rekening $productName Anda dengan nomor ${newAccountNumber.substring(0, 4)}...${newAccountNumber.substring(newAccountNumber.length - 4)} telah aktif.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            // --- PERBAIKAN DI SINI ---
            ElevatedButton(
              onPressed: () {
                // Navigasi saat tombol ditekan
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    // Arahkan ke MainScreen dan set index ke halaman Akun (index 4)
                    builder: (context) => MainScreen(userId: userId, initialIndex: 4),
                  ),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text("Lihat Akun Saya"),
            )
          ],
        ),
      ),
    );
  }
}