import 'package:brimo_clone/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart'; // <-- IMPOR PACKAGE BARU

class TransactionDetailPage extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFormatter = DateFormat('dd MMMM yyyy, HH:mm:ss', 'id_ID');
    final bool isDebit = transaction.amount < 0;

    // --- FUNGSI UNTUK MEMBAGIKAN BUKTI ---
    void _shareReceipt() {
      final amount = currencyFormatter.format(transaction.amount.abs());
      final date = dateFormatter.format(transaction.timestamp.toDate());

      final String receiptText = """
      *** BUKTI TRANSAKSI BERHASIL ***

      Jenis Transaksi: ${transaction.description}
      Nominal: $amount
      Tanggal: $date
      Status: Berhasil
      No. Referensi: BRI123XYZABC

      Terima kasih telah bertransaksi dengan BRImo.
      """;

      Share.share(receiptText);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),
                  const SizedBox(height: 16),
                  const Text(
                    "Transaksi Berhasil",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dateFormatter.format(transaction.timestamp.toDate()),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "DETAIL",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const Divider(thickness: 1.5),
            _buildDetailRow("Jenis Transaksi", transaction.description),
            _buildDetailRow("Nominal Transaksi", currencyFormatter.format(transaction.amount.abs())),
            _buildDetailRow("Tipe", isDebit ? "Keluar" : "Masuk"),
            _buildDetailRow("Status", "Berhasil"),
            _buildDetailRow("Nomor Referensi", "BRI123XYZABC"), // Contoh nomor referensi
            const Spacer(),
            ElevatedButton.icon(
              // --- PERUBAHAN DI SINI ---
              onPressed: _shareReceipt,
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text("Bagikan", style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}