import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherPage extends StatelessWidget {
  final String userId;
  const VoucherPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Voucher Game & Streaming"),
          backgroundColor: Theme.of(context).primaryColor,
          // --- PERBAIKAN DI SINI ---
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white, // Warna garis bawah tab yang aktif
            labelColor: Colors.white, // Warna teks tab yang aktif
            unselectedLabelColor: Colors.white70, // Warna teks tab yang tidak aktif
            tabs: [
              Tab(text: "Google Play"),
              Tab(text: "Steam"),
              Tab(text: "Netflix"),
              Tab(text: "Spotify"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildVoucherList(context, "Google Play", Icons.play_circle_fill, [50000, 100000, 150000]),
            _buildVoucherList(context, "Steam", Icons.videogame_asset, [120000, 250000, 600000]),
            _buildVoucherList(context, "Netflix", Icons.live_tv, [54000, 120000, 186000]),
            _buildVoucherList(context, "Spotify", Icons.music_note, [55000, 165000, 330000]),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherList(BuildContext context, String category, IconData icon, List<int> prices) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: prices.length,
      itemBuilder: (context, index) {
        final price = prices[index];
        final voucherName = "Voucher $category";
        final voucherPrice = currencyFormatter.format(price);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            title: Text(voucherName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(voucherPrice),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferConfirmationPage(
                      userId: userId,
                      bankName: "Voucher",
                      accountNumber: category,
                      amount: price,
                      recipientName: voucherName,
                      adminFee: 1000,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text("Beli"),
            ),
          ),
        );
      },
    );
  }
}