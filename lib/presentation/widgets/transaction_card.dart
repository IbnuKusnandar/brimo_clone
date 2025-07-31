// lib/presentation/widgets/transaction_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    // Transaksi pengeluaran jika amount bernilai negatif
    final bool isDebit = transaction.amount < 0;
    final String formattedAmount = currencyFormatter.format(transaction.amount.abs());
    final Color amountColor = isDebit ? Colors.black87 : Colors.green;
    final String prefix = isDebit ? "- " : "+ ";

    return ListTile(
      title: Text(
        transaction.description, // Ganti dengan deskripsi
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
          DateFormat('HH:mm:ss \'WIB\'', 'id_ID').format(transaction.timestamp.toDate())
      ),
      trailing: Text(
        prefix + formattedAmount,
        style: TextStyle(
          color: amountColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}