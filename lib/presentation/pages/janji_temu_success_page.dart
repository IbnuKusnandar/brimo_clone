import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class JanjiTemuSuccessPage extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String time;
  final String date;

  const JanjiTemuSuccessPage({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Janji Temu Dibuat"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/success_doctor.json', // Menggunakan animasi sukses
                width: 200,
                height: 200,
                repeat: false,
              ),
              const SizedBox(height: 20),
              const Text(
                "Janji Temu Berhasil Dibuat!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildDetailRow("Dokter", doctorName),
              _buildDetailRow("Spesialis", specialty),
              _buildDetailRow("Tanggal", date),
              _buildDetailRow("Jam", time),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Kembali ke halaman utama (root)
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Kembali ke Home"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}