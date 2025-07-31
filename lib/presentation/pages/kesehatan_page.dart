import 'package:brimo_clone/presentation/pages/asuransi_kesehatan_page.dart';
import 'package:brimo_clone/presentation/pages/beli_obat_page.dart';
import 'package:brimo_clone/presentation/pages/janji_temu_rs_page.dart';
import 'package:brimo_clone/presentation/pages/konsultasi_dokter_page.dart';
import 'package:flutter/material.dart';

class KesehatanPage extends StatelessWidget {
  final String userId;
  const KesehatanPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> healthServices = [
      {'name': 'Konsultasi Dokter', 'icon': Icons.medical_services, 'page': const KonsultasiDokterPage()},
      {'name': 'Beli Obat', 'icon': Icons.local_pharmacy, 'page': BeliObatPage(userId: userId)},
      {'name': 'Janji Temu Rumah Sakit', 'icon': Icons.business, 'page': const JanjiTemuRsPage()},
      {'name': 'Asuransi Kesehatan', 'icon': Icons.shield, 'page': const AsuransiKesehatanPage()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Layanan Kesehatan"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: healthServices.length,
        itemBuilder: (context, index) {
          final service = healthServices[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(service['icon'], size: 40, color: Theme.of(context).primaryColor),
              title: Text(service['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => service['page']));
              },
            ),
          );
        },
      ),
    );
  }
}