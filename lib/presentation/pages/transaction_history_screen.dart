import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';
import '../widgets/transaction_card.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final String userId;
  const TransactionHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Transaksi")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('transactions')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada riwayat transaksi."));
          }

          final transactions = snapshot.data!.docs
              .map((doc) => TransactionModel.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final trx = transactions[index];
              return TransactionCard(transaction: trx);
            },
          );
        },
      ),
    );
  }
}