import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DaftarAsuransiSuccessPage extends StatelessWidget {
  final String productName;
  const DaftarAsuransiSuccessPage({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/asuransi_success.json',
              width: 250,
              height: 250,
              repeat: false,
            ),
            const SizedBox(height: 20),
            Text(
              "Pendaftaran Diproses!",
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
                "Pengajuan Anda untuk $productName sedang kami proses. Tim kami akan segera menghubungi Anda.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text("Kembali ke Home"),
            )
          ],
        ),
      ),
    );
  }
}