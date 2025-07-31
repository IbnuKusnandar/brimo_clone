import 'package:brimo_clone/presentation/pages/donation_input_page.dart';
import 'package:flutter/material.dart';

class ZakatPage extends StatelessWidget {
  final String userId;
  // --- PERBAIKAN DI SINI ---
  // Hapus 'const' dari constructor
  const ZakatPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final List<String> zakatInstitutions = [
      'Badan Amil Zakat Nasional',
      'Dompet Dhuafa',
      'LAZISNU',
      'LAZISMU',
      'Rumah Zakat',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Lembaga Zakat"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: zakatInstitutions.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final institution = zakatInstitutions[index];
          return ListTile(
            title: Text(institution),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationInputPage(
                    userId: userId,
                    donationType: "Zakat",
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