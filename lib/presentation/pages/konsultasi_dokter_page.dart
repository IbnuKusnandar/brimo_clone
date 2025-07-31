import 'package:brimo_clone/presentation/pages/chat_dokter_page.dart';
import 'package:flutter/material.dart';

class KonsultasiDokterPage extends StatelessWidget {
  const KonsultasiDokterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar dokter contoh
    final List<Map<String, String>> doctors = [
      {'name': 'Dr. Budi Santoso', 'specialty': 'Dokter Umum'},
      {'name': 'Dr. Siti Aminah', 'specialty': 'Dokter Anak'},
      {'name': 'Dr. Agus Wijaya', 'specialty': 'Dokter Penyakit Dalam'},
      {'name': 'Dr. Dewi Lestari', 'specialty': 'Dokter Kandungan'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konsultasi Dokter"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.person_pin, size: 40, color: Theme.of(context).primaryColor),
              title: Text(doctor['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(doctor['specialty']!),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDokterPage(doctorName: doctor['name']!),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Chat"),
              ),
            ),
          );
        },
      ),
    );
  }
}