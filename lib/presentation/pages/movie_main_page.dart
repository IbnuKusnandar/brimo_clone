import 'package:brimo_clone/presentation/pages/tiket_cgv_page.dart';
import 'package:brimo_clone/presentation/pages/tiket_xxi_page.dart';
import 'package:flutter/material.dart';

class MovieMainPage extends StatelessWidget {
  final String userId;
  const MovieMainPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Bioskop"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          _buildCinemaOption(
              context,
              cinemaName: "XXI",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TiketXxiPage(userId: userId)));
              }
          ),
          _buildCinemaOption(
              context,
              cinemaName: "CGV",
              onTap: () {
                // --- PERUBAHAN DI SINI ---
                Navigator.push(context, MaterialPageRoute(builder: (context) => TiketCgvPage(userId: userId)));
              }
          ),
        ],
      ),
    );
  }

  Widget _buildCinemaOption(BuildContext context, {required String cinemaName, required VoidCallback onTap}) {
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
              Icon(Icons.movie_filter, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(cinemaName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}