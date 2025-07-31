import 'package:brimo_clone/presentation/pages/hotel_page.dart';
import 'package:brimo_clone/presentation/pages/kesehatan_page.dart';
import 'package:brimo_clone/presentation/pages/tiket_pesawat_page.dart';
import 'package:brimo_clone/presentation/pages/voucher_belanja_page.dart';
import 'package:flutter/material.dart';

class LifestylePage extends StatelessWidget {
  final String userId;
  const LifestylePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lifestyle"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildLifestyleOption(context, "Tiket Pesawat", Icons.flight, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TiketPesawatPage(userId: userId)));
          }),
          _buildLifestyleOption(context, "Hotel", Icons.hotel, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HotelPage(userId: userId)));
          }),
          _buildLifestyleOption(context, "Voucher Belanja", Icons.shopping_cart, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => VoucherBelanjaPage(userId: userId)));
          }),
          _buildLifestyleOption(context, "Kesehatan", Icons.local_hospital, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => KesehatanPage(userId: userId)));
          }),
        ],
      ),
    );
  }

  Widget _buildLifestyleOption(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}