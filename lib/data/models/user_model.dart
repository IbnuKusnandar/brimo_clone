import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final num balance;
  final Timestamp createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
    required this.createdAt,
  });

  // Factory constructor untuk membuat UserModel dari DocumentSnapshot Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? 'Tanpa Nama',
      email: data['email'] ?? '',
      balance: data['balance'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}