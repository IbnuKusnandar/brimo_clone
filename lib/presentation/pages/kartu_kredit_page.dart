import 'package:brimo_clone/presentation/pages/kartu_kredit_bank_page.dart';
import 'package:brimo_clone/presentation/pages/pengajuan_kartu_page.dart';
import 'package:flutter/material.dart';

class KartuKreditPage extends StatelessWidget {
  final String userId;
  const KartuKreditPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kartu Kredit"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- Fitur Pembayaran Kartu Kredit ---
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KartuKreditBankPage(userId: userId)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.payment, size: 40, color: Colors.blue),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pembayaran Kartu Kredit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("Bayar tagihan Kartu Kredit Anda"),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Fitur Pengajuan Kartu Kredit ---
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PengajuanKartuPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add_card, size: 40, color: Colors.green),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pengajuan Kartu Kredit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("Ajukan Kartu Kredit BRI baru"),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}