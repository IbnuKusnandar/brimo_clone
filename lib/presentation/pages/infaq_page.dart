import 'package:brimo_clone/presentation/pages/donation_input_page.dart';
import 'package:flutter/material.dart';

class InfaqPage extends StatelessWidget {
  final String userId;
  // --- PERBAIKAN DI SINI ---
  // Hapus 'const' dari constructor
  const InfaqPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final List<String> infaqInstitutions = [
      'Aksi Cepat Tanggap (ACT)',
      'Rumah Yatim',
      'Baitul Maal Hidayatullah (BMH)',
      'Kitabisa.com',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Lembaga Infaq/Kurban"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: infaqInstitutions.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final institution = infaqInstitutions[index];
          return ListTile(
            title: Text(institution),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationInputPage(
                    userId: userId,
                    donationType: "Infaq",
                    institutionName: institution,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}