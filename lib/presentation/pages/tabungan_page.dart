import 'package:brimo_clone/presentation/pages/buka_rekening_form_page.dart';
import 'package:flutter/material.dart';

class TabunganPage extends StatelessWidget {
  // --- PERBAIKAN DI SINI ---
  final String userId;
  const TabunganPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Daftar produk tabungan contoh
    final List<Map<String, String>> savingsProducts = [
      {
        'name': 'BritAma',
        'description': 'Tabungan harian dengan berbagai kemudahan transaksi.',
        'image': 'assets/images/britama.png',
      },
      {
        'name': 'Simpedes',
        'description': 'Tabungan untuk masyarakat pedesaan dengan undian hadiah.',
        'image': 'assets/images/simpedes.png',
      },
      {
        'name': 'Tabungan Syariah',
        'description': 'Rencanakan ibadah haji Anda dengan lebih mudah.',
        'image': 'assets/images/tabungan_syariah.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buka Rekening Tabungan"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: savingsProducts.length,
        itemBuilder: (context, index) {
          final product = savingsProducts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Image.asset(
                    product['image']!,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product['name']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['description']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BukaRekeningFormPage(
                            // Meneruskan userId ke halaman form
                            userId: userId,
                            productName: product['name']!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Buka Rekening"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}