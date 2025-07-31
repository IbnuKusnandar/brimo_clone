// Impor halaman fitur (tanpa bahasa_page.dart)
import 'package:brimo_clone/presentation/pages/fast_menu_page.dart';
import 'package:brimo_clone/presentation/pages/pengelolaan_kartu_page.dart';
import 'package:brimo_clone/presentation/pages/sumber_dana_qris_page.dart';
import 'package:brimo_clone/presentation/pages/ubah_password_page.dart';
import 'package:brimo_clone/presentation/pages/ubah_pin_page.dart';
import 'package:brimo_clone/presentation/pages/update_rekening_page.dart';

// Impor lainnya
import 'package:brimo_clone/presentation/pages/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatelessWidget {
  final String userId;
  const AccountPage({super.key, required this.userId});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Akun")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Info Pengguna
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
                    builder: (context, snapshot){
                      if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: Colors.white,));
                      final data = snapshot.data!.data() as Map<String, dynamic>;
                      final name = data['name'] ?? 'Pengguna';
                      final initial = name.isNotEmpty ? name[0].toUpperCase() : 'P';

                      return Row(
                        children: [
                          CircleAvatar(radius: 30, child: Text(initial, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const Text("Beta Tester Versi 0.0.1", style: TextStyle(color: Colors.white70)),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                ),
              ),
            ),

            // Section Pengaturan
            _buildSectionHeader("Pengaturan"),
            _buildMenuItem(context, Icons.grid_view_outlined, "Fast Menu", () => _navigateTo(context, const FastMenuPage())),
            _buildMenuItem(context, Icons.credit_card_outlined, "Update Rekening", () => _navigateTo(context, const UpdateRekeningPage())),
            _buildMenuItem(context, Icons.manage_accounts_outlined, "Pengelolaan Kartu", () => _navigateTo(context, const PengelolaanKartuPage())),
            _buildMenuItem(context, Icons.qr_code_2_outlined, "Sumber Dana QRIS", () => _navigateTo(context, const SumberDanaQrisPage())),
            // --- MENU BAHASA DIHAPUS DARI SINI ---

            // Section Keamanan
            _buildSectionHeader("Keamanan"),
            _buildMenuItem(context, Icons.password_outlined, "Ubah Pin", () => _navigateTo(context, const UbahPinPage())),
            _buildMenuItem(context, Icons.lock_outline, "Ubah Password", () => _navigateTo(context, const UbahPasswordPage())),

            // Tombol Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () => _logout(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: const Color(0xFF00529B)),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        const Divider(indent: 16, height: 1),
      ],
    );
  }
}