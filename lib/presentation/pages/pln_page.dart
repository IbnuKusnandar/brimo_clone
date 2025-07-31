import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class PlnPage extends StatelessWidget {
  final String userId;
  const PlnPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Listrik PLN"),
          backgroundColor: Theme.of(context).primaryColor,
          // --- PERBAIKAN DI SINI ---
          bottom: const TabBar(
            indicatorColor: Colors.white, // Warna garis bawah tab yang aktif
            labelColor: Colors.white, // Warna teks tab yang aktif
            unselectedLabelColor: Colors.white70, // Warna teks tab yang tidak aktif
            tabs: [
              Tab(text: "Token Listrik"),
              Tab(text: "Tagihan Listrik"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PlnTokenTab(userId: userId),
            PlnTagihanTab(userId: userId),
          ],
        ),
      ),
    );
  }
}

// --- TAB UNTUK PEMBELIAN TOKEN LISTRIK ---
class PlnTokenTab extends StatefulWidget {
  final String userId;
  const PlnTokenTab({super.key, required this.userId});

  @override
  State<PlnTokenTab> createState() => _PlnTokenTabState();
}

class _PlnTokenTabState extends State<PlnTokenTab> {
  final _idPelangganController = TextEditingController();

  void _onNominalTap(int amount) {
    if (_idPelangganController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ID Pelanggan tidak boleh kosong."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferConfirmationPage(
          userId: widget.userId,
          bankName: "PLN Prepaid (Token)",
          accountNumber: _idPelangganController.text,
          amount: amount,
          recipientName: "Bapak Budi (Contoh)",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextField(
            controller: _idPelangganController,
            decoration: const InputDecoration(
              labelText: 'ID Pelanggan atau No. Meter',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildNominalButton("Rp 20.000", 20000),
                _buildNominalButton("Rp 50.000", 50000),
                _buildNominalButton("Rp 100.000", 100000),
                _buildNominalButton("Rp 200.000", 200000),
                _buildNominalButton("Rp 500.000", 500000),
                _buildNominalButton("Rp 1.000.000", 1000000),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNominalButton(String text, int amount) {
    return ElevatedButton(
      onPressed: () => _onNominalTap(amount),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}


// --- TAB UNTUK PEMBAYARAN TAGIHAN LISTRIK ---
class PlnTagihanTab extends StatefulWidget {
  final String userId;
  const PlnTagihanTab({super.key, required this.userId});

  @override
  State<PlnTagihanTab> createState() => _PlnTagihanTabState();
}

class _PlnTagihanTabState extends State<PlnTagihanTab> {
  final _idPelangganController = TextEditingController();

  void _onBayarTap() {
    if (_idPelangganController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ID Pelanggan tidak boleh kosong."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulasi data tagihan
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferConfirmationPage(
          userId: widget.userId,
          bankName: "PLN Postpaid (Tagihan)",
          accountNumber: _idPelangganController.text,
          amount: 250000, // Nominal tagihan (contoh)
          recipientName: "Ibu Siti (Contoh)",
          adminFee: 2000,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextField(
            controller: _idPelangganController,
            decoration: const InputDecoration(
              labelText: 'ID Pelanggan',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onBayarTap,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16)
              ),
              child: const Text("Bayar Tagihan", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}