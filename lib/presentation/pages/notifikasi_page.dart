import 'package:brimo_clone/data/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService();
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getNotificationsStream(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Tidak ada notifikasi."));
          }

          final notifications = snapshot.data!.docs;

          return ListView.separated(
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notificationData = notifications[index].data() as Map<String, dynamic>;
              final timestamp = (notificationData['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();

              return ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue),
                title: Text(notificationData['title'] ?? 'Tanpa Judul', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(notificationData['subtitle'] ?? 'Tanpa Keterangan'),
                trailing: Text(
                    DateFormat('dd MMM, HH:mm').format(timestamp),
                    style: const TextStyle(fontSize: 12, color: Colors.grey)
                ),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}