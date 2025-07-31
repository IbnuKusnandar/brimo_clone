import 'package:brimo_clone/presentation/pages/daftar_asuransi_page.dart';
import 'package:flutter/material.dart';

class AsuransiKesehatanPage extends StatelessWidget {
  const AsuransiKesehatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Asuransi Kesehatan"),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "BRI Life"),
              Tab(text: "AXA Mandiri"),
              Tab(text: "Prudential"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInsuranceProduct(
              context,
              productName: "Asuransi Sehat BRI Life",
              description: "Perlindungan rawat inap dan jalan dengan premi terjangkau mulai dari Rp 50.000/bulan.",
              imagePath: "assets/images/logo_brilife.png", // Ganti dengan gambar yang sesuai
            ),
            _buildInsuranceProduct(
              context,
              productName: "Asuransi Kesehatan AXA",
              description: "Manfaat lengkap untuk perlindungan kesehatan seluruh keluarga Anda.",
              imagePath: "assets/images/logo_axa.png", // Ganti dengan gambar yang sesuai
            ),
            _buildInsuranceProduct(
              context,
              productName: "PRUPrime Healthcare",
              description: "Asuransi kesehatan dengan jangkauan perlindungan hingga seluruh dunia.",
              imagePath: "assets/images/logo_pruprime.png", // Ganti dengan gambar yang sesuai
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceProduct(BuildContext context, {required String productName, required String description, required String imagePath}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, height: 180, width: double.infinity, fit: BoxFit.contain),
          const SizedBox(height: 24),
          Text(productName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(description, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // --- PERUBAHAN DI SINI ---
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DaftarAsuransiPage(productName: productName),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Daftar Sekarang"),
          )
        ],
      ),
    );
  }
}