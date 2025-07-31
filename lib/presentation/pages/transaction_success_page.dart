import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class TransactionSuccessPage extends StatefulWidget {
  final String message;
  final int amount;
  final String? voucherCode;

  const TransactionSuccessPage({
    super.key,
    required this.message,
    required this.amount,
    this.voucherCode,
  });

  @override
  State<TransactionSuccessPage> createState() => _TransactionSuccessPageState();
}

class _TransactionSuccessPageState extends State<TransactionSuccessPage> {
  @override
  void initState() {
    super.initState();
    // Kembali ke halaman utama setelah beberapa detik
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/Success.json', // Menggunakan animasi yang sudah ada
              width: 250,
              height: 250,
              repeat: true,
            ),
            const SizedBox(height: 20),
            const Text(
              "Transaksi Berhasil",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00529B),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currencyFormatter.format(widget.amount),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}