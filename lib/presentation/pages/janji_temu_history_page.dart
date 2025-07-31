import 'package:flutter/material.dart';

class JanjiTemuHistoryPage extends StatelessWidget {
  const JanjiTemuHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar riwayat janji temu (contoh)
    final List<Map<String, String>> history = [
      {
        'doctor': 'Dr. Budi Santoso',
        'specialty': 'Dokter Umum',
        'date': '25 Juli 2025, 10:00',
        'status': 'Selesai',
      },
      {
        'doctor': 'Dr. Siti Aminah',
        'specialty': 'Dokter Anak',
        'date': '15 Juli 2025, 14:00',
        'status': 'Selesai',
      },
      {
        'doctor': 'Dr. Agus Wijaya',
        'specialty': 'Penyakit Dalam',
        'date': '05 Agustus 2025, 16:30',
        'status': 'Akan Datang',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Janji Temu"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          final isCompleted = item['status'] == 'Selesai';
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(
                isCompleted ? Icons.check_circle : Icons.watch_later,
                color: isCompleted ? Colors.green : Colors.orange,
                size: 40,
              ),
              title: Text(item['doctor']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${item['specialty']}\n${item['date']}"),
              trailing: Text(
                item['status']!,
                style: TextStyle(
                  color: isCompleted ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}