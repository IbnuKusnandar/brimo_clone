import 'package:brimo_clone/presentation/pages/buka_rekening_pin_page.dart';
import 'package:flutter/material.dart';

class BukaRekeningConfirmationPage extends StatelessWidget {
  final String userId;
  final String productName;
  final String fullName;
  final String ktpNumber;
  final String npwpNumber;
  final String email;
  final String phoneNumber;

  const BukaRekeningConfirmationPage({
    super.key,
    required this.userId,
    required this.productName,
    required this.fullName,
    required this.ktpNumber,
    required this.npwpNumber,
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Buka Rekening"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Jenis Tabungan", productName),
            _buildDetailRow("Nama Lengkap", fullName),
            _buildDetailRow("Nomor KTP", ktpNumber),
            _buildDetailRow("Nomor NPWP", npwpNumber.isNotEmpty ? npwpNumber : "-"),
            _buildDetailRow("Email", email),
            _buildDetailRow("Nomor Ponsel", phoneNumber),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BukaRekeningPinPage(
                        userId: userId,
                        productName: productName,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Konfirmasi"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
        ],
      ),
    );
  }
}