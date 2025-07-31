import 'package:brimo_clone/presentation/pages/pdam_input_page.dart';
import 'package:flutter/material.dart';

class PdamRegionPage extends StatelessWidget {
  final String userId;
  const PdamRegionPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Daftar PDAM (contoh)
    final List<String> pdamRegions = [
      'PDAM Kota Bandung',
      'PDAM Kota Surabaya',
      'PDAM Kota Semarang',
      'PDAM Jakarta (PALYJA)',
      'PDAM Kota Medan',
      'PDAM Kab. Bogor',
      'PDAM Kota Depok',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Wilayah PDAM"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: pdamRegions.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final region = pdamRegions[index];
          return ListTile(
            title: Text(region),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdamInputPage(
                    userId: userId,
                    selectedRegion: region,
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