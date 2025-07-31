import 'package:flutter/material.dart';

class PusatBantuanPage extends StatelessWidget {
  const PusatBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar pertanyaan dan jawaban contoh
    final List<Map<String, String>> faqList = [
      {
        'question': 'Bagaimana cara mengubah PIN?',
        'answer': 'Anda dapat mengubah PIN melalui menu Akun > Keamanan > Ubah PIN.',
      },
      {
        'question': 'Berapa biaya admin untuk transfer antar bank?',
        'answer': 'Biaya administrasi untuk transfer antar bank adalah Rp 6.500 per transaksi.',
      },
      {
        'question': 'Bagaimana cara memblokir kartu?',
        'answer': 'Anda dapat memblokir kartu melalui menu Akun > Pengaturan > Pengelolaan Kartu.',
      },
      {
        'question': 'Apakah saya bisa membuka rekening baru?',
        'answer': 'Ya, Anda bisa membuka rekening baru melalui menu Keuangan > Tabungan.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pusat Bantuan"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          final faq = faqList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ExpansionTile(
              leading: const Icon(Icons.help_outline),
              title: Text(faq['question']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(faq['answer']!),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}