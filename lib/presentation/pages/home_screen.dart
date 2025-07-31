// lib/presentation/pages/home_screen.dart

import 'package:brimo_clone/data/models/transaction_model.dart';
import 'package:brimo_clone/presentation/pages/login_screen.dart';
import 'package:brimo_clone/presentation/pages/transaction_history_screen.dart';
import 'package:brimo_clone/presentation/widgets/transaction_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TransactionHistoryScreen(userId: widget.userId),
          ),
        );
        break;
    // Add navigation for other items if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .snapshots();

    final Stream<QuerySnapshot> transactionStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('transactions')
        .orderBy('timestamp', descending: true)
        .limit(3) // Limit to 3 recent transactions on home screen
        .snapshots();

    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("Data pengguna tidak ditemukan."));
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final String name = userData['name'] ?? 'Pengguna';
            final num balance = userData['balance'] ?? 0;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang, $name!',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Saldo Anda',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currencyFormatter.format(balance),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF00529B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Catatan Keuanganmu Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Catatan Keuanganmu',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TransactionHistoryScreen(userId: widget.userId),
                            ),
                          );
                        },
                        icon: const Icon(Icons.visibility),
                        label: const Text('Tampilkan'),
                      ),
                    ],
                  ),
                  Text(
                      '${DateFormat.yMMMMd('id_ID').format(DateTime.now())} - ${DateFormat.yMMMMd('id_ID').format(DateTime.now())}'),
                  const SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                    stream: transactionStream,
                    builder: (context, transactionSnapshot) {
                      if (transactionSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!transactionSnapshot.hasData ||
                          transactionSnapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text("Belum ada riwayat transaksi."));
                      }

                      final transactions = transactionSnapshot.data!.docs
                          .map((doc) => TransactionModel.fromFirestore(doc))
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final trx = transactions[index];
                          return TransactionCard(transaction: trx);
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Mutasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'QRIS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Aktivitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF00529B),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}