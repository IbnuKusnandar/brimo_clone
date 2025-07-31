import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String type; // e.g., 'Transfer Keluar', 'Pembayaran', 'Top Up'
  final double amount;
  final String description;
  final Timestamp timestamp;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.timestamp,
  });

  // Factory constructor untuk membuat TransactionModel dari Firestore
  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      type: data['type'] ?? 'Transaksi',
      amount: (data['amount'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}