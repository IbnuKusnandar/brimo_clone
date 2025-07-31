import 'package:brimo_clone/data/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- FUNGSI PENGGUNA ---

  // Mengambil data pengguna secara real-time (stream)
  Stream<DocumentSnapshot> getUserStream(String userId) {
    return _db.collection('users').doc(userId).snapshots();
  }

  // Mengambil data pengguna sekali (bukan stream)
  Future<DocumentSnapshot> getUserData(String userId) {
    return _db.collection('users').doc(userId).get();
  }

  // Memperbarui data pengguna
  Future<void> updateUserData(String userId, String name, String email, String phoneNumber) {
    return _db.collection('users').doc(userId).update({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }

  // Memperbarui PIN pengguna
  Future<void> updateUserPin(String userId, String newPin) {
    return _db.collection('users').doc(userId).update({'pin': newPin});
  }

  // --- FUNGSI REKENING ---

  // Mengambil daftar rekening pengguna secara real-time (stream)
  Stream<QuerySnapshot> getAccountsStream(String userId) {
    return _db.collection('users').doc(userId).collection('accounts').snapshots();
  }

  // --- FUNGSI TRANSAKSI ---

  // Mengambil data transaksi secara real-time (stream)
  Stream<List<TransactionModel>> getTransactionsStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList());
  }

  // Mengambil data transaksi untuk periode tertentu (untuk e-Statement)
  Future<List<TransactionModel>> getTransactionsForPeriod(
      String userId, int year, int month) async {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0, 23, 59, 59);

    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .where('timestamp', isGreaterThanOrEqualTo: firstDay)
        .where('timestamp', isLessThanOrEqualTo: lastDay)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList();
  }

  // Menambahkan transaksi baru dan memperbarui saldo
  Future<void> addTransaction(String userId, String description, int amount) async {
    final userRef = _db.collection('users').doc(userId);
    final transactionRef = userRef.collection('transactions').doc();
    final mainAccountRef = userRef.collection('accounts').doc('rekening_utama');

    await _db.runTransaction((transaction) async {
      final userSnapshot = await transaction.get(userRef);
      final accountSnapshot = await transaction.get(mainAccountRef);

      if (!userSnapshot.exists || !accountSnapshot.exists) {
        throw Exception("Pengguna atau rekening utama tidak ditemukan!");
      }

      final currentBalance = (userSnapshot.data() as Map<String, dynamic>)['balance'] ?? 0;

      final newBalance = currentBalance - amount;
      if (newBalance < 0) {
        throw Exception("Saldo tidak mencukupi!");
      }

      // Update saldo di dua lokasi
      transaction.update(userRef, {'balance': newBalance});
      transaction.update(mainAccountRef, {'balance': newBalance});

      // Buat catatan transaksi baru
      transaction.set(transactionRef, {
        'description': description,
        'amount': -amount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });

    // Buat notifikasi setelah transaksi selesai
    await addNotification(userId, "Transaksi Berhasil", "$description sebesar Rp$amount berhasil.");
  }

  // --- FUNGSI NOTIFIKASI ---

  // Menambahkan notifikasi baru
  Future<void> addNotification(String userId, String title, String subtitle) {
    return _db.collection('users').doc(userId).collection('notifications').add({
      'title': title,
      'subtitle': subtitle,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }

  // Mengambil stream notifikasi
  Stream<QuerySnapshot> getNotificationsStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // --- FUNGSI KARTU ---

  // Mengambil daftar kartu pengguna secara real-time (stream)
  Stream<QuerySnapshot> getCardsStream(String userId) {
    return _db.collection('users').doc(userId).collection('cards').snapshots();
  }

  // Memperbarui status blokir kartu
  Future<void> updateCardBlockStatus(String userId, String cardId, bool isBlocked) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('cards')
        .doc(cardId)
        .update({'isBlocked': isBlocked});
  }
}