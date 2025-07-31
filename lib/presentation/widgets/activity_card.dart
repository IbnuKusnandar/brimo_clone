import 'package:brimo_clone/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  final TransactionModel transaction;

  const ActivityCard({super.key, required this.transaction});

  // Fungsi untuk memilih ikon berdasarkan deskripsi transaksi
  IconData _getIconForDescription(String description) {
    String descLower = description.toLowerCase();
    if (descLower.contains('qris')) {
      return Icons.qr_code_scanner;
    } else if (descLower.contains('transfer')) {
      return Icons.swap_horiz;
    } else if (descLower.contains('listrik')) {
      return Icons.lightbulb_outline;
    } else if (descLower.contains('fee')) {
      return Icons.receipt_long_outlined;
    }
    return Icons.wallet_outlined; // Ikon default
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    final date = DateFormat('dd MMMM yyyy HH:mm', 'id_ID').format(transaction.timestamp.toDate());
    final bool isDebit = transaction.amount < 0; // Transaksi keluar

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue.shade50,
              child: Icon(
                _getIconForDescription(transaction.description),
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currencyFormatter.format(transaction.amount.abs()),
                    style: TextStyle(
                      fontSize: 14,
                      color: isDebit ? Colors.black87 : Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Sukses",
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}