import 'package:brimo_clone/presentation/pages/infaq_page.dart';
import 'package:brimo_clone/presentation/pages/zakat_page.dart';
import 'package:flutter/material.dart';

class DonasiPage extends StatelessWidget {
  final String userId;
  // --- PERBAIKAN DI SINI ---
  // Hapus 'const' dari constructor
  DonasiPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donasi"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          _buildDonationCategory(
              context,
              title: "Zakat",
              description: "Sucikan harta, tenangkan jiwa.",
              icon: Icons.volunteer_activism,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ZakatPage(userId: userId)));
              }
          ),
          _buildDonationCategory(
              context,
              title: "Infaq & Kurban",
              description: "Berbagi kebaikan, raih keberkahan.",
              icon: Icons.mosque,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InfaqPage(userId: userId)));
              }
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCategory(BuildContext context, {required String title, required String description, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(description, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}