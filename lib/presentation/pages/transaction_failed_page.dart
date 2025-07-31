import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TransactionFailedPage extends StatefulWidget {
  final String message;

  const TransactionFailedPage({
    super.key,
    required this.message,
  });

  @override
  State<TransactionFailedPage> createState() => _TransactionFailedPageState();
}

class _TransactionFailedPageState extends State<TransactionFailedPage> {
  @override
  void initState() {
    super.initState();
    // Kembali ke halaman sebelumnya setelah 6 detik
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/transaction_failed.json', // Pastikan path ini benar
                width: 290,
                height: 290,
                repeat: true,
              ),
              const SizedBox(height: 20),
              const Text(
                "Saldo Anda Tidak Cukup",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              // --- PERBAIKAN DI SINI ---
              // Widget Flexible memastikan teks akan turun ke bawah jika terlalu panjang
              // dan tidak akan menyebabkan overflow error.
              Flexible(
                child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}