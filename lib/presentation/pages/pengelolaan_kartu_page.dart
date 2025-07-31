import 'package:brimo_clone/data/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PengelolaanKartuPage extends StatefulWidget {
  const PengelolaanKartuPage({super.key});

  @override
  State<PengelolaanKartuPage> createState() => _PengelolaanKartuPageState();
}

class _PengelolaanKartuPageState extends State<PengelolaanKartuPage> {
  final FirestoreService _firestoreService = FirestoreService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  void _showBlockDialog(String cardId, Map<String, dynamic> cardData) {
    final bool isCurrentlyBlocked = cardData['isBlocked'] ?? false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${isCurrentlyBlocked ? 'Buka Blokir' : 'Blokir'} Kartu?"),
        content: Text("Apakah Anda yakin ingin ${isCurrentlyBlocked ? 'membuka blokir' : 'memblokir'} kartu ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              _firestoreService.updateCardBlockStatus(userId, cardId, !isCurrentlyBlocked);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Kartu berhasil ${isCurrentlyBlocked ? 'dibuka blokirnya' : 'diblokir'}.")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isCurrentlyBlocked ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(isCurrentlyBlocked ? 'Buka Blokir' : 'Blokir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pengelolaan Kartu"),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Kartu Debit"),
              Tab(text: "Kartu Kredit"),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestoreService.getCardsStream(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Tidak ada kartu yang terdaftar."));
            }

            final allCards = snapshot.data!.docs;
            final debitCards = allCards.where((card) => card['type'] == 'Kartu Debit').toList();
            final creditCards = allCards.where((card) => card['type'] == 'Kartu Kredit').toList();

            return TabBarView(
              children: [
                _buildCardList(debitCards),
                _buildCardList(creditCards),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardList(List<QueryDocumentSnapshot> cards) {
    if (cards.isEmpty) {
      return const Center(child: Text("Tidak ada kartu di kategori ini."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        final cardData = card.data() as Map<String, dynamic>;
        final bool isBlocked = cardData['isBlocked'] ?? false;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          color: isBlocked ? Colors.grey[300] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardData['type'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isBlocked ? Colors.grey[600] : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cardData['number'],
                  style: TextStyle(
                    fontSize: 16,
                    color: isBlocked ? Colors.grey[600] : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showBlockDialog(card.id, cardData),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isBlocked ? Colors.green : Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(isBlocked ? "Buka Blokir" : "Blokir"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}