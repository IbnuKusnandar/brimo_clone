import 'package:brimo_clone/presentation/pages/transfer_pin_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransferConfirmationPage extends StatelessWidget {
  final String userId;
  final String bankName;
  final String accountNumber;
  final int amount;
  final String recipientName;
  final int adminFee; // <-- Parameter baru untuk biaya admin

  const TransferConfirmationPage({
    super.key,
    required this.userId,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    required this.recipientName,
    this.adminFee = 0, // Default biaya admin adalah 0
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final totalAmount = amount + adminFee; // Hitung total

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Transaksi"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Jenis Transaksi", bankName),
            _buildDetailRow("Tujuan", accountNumber),
            _buildDetailRow("Nama Penerima", recipientName),
            const Divider(height: 40),
            _buildDetailRow("Nominal Transaksi", currencyFormatter.format(amount)),
            // --- PERUBAHAN DI SINI ---
            _buildDetailRow("Biaya Admin", currencyFormatter.format(adminFee)),
            const Divider(height: 40),
            // Tampilkan total yang sudah dihitung
            _buildDetailRow("Total", currencyFormatter.format(totalAmount), isTotal: true),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransferPinPage(
                      userId: userId,
                      amount: totalAmount, // Kirim total ke halaman PIN
                      description: "$bankName ke $recipientName",
                    )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Konfirmasi", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}