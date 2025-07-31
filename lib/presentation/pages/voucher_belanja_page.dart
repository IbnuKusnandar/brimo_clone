import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherBelanjaPage extends StatelessWidget {
  final String userId;
  const VoucherBelanjaPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Daftar voucher belanja contoh
    final List<Map<String, dynamic>> vouchers = [
      {'name': 'Voucher Tokped Rp 100.000', 'brand': 'Tokopedia', 'price': 100000},
      {'name': 'Voucher Shopee Rp 50.000', 'brand': 'Shopee', 'price': 50000},
      {'name': 'Voucher GF Rp 25.000', 'brand': 'Grab', 'price': 25000},
      {'name': 'Voucher GoFood Rp 25.000', 'brand': 'Gojek', 'price': 25000},
    ];

    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Voucher Belanja"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.shopping_cart, size: 40, color: Theme.of(context).primaryColor),
              title: Text(voucher['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Harga: ${currencyFormatter.format(voucher['price'])}"),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferConfirmationPage(
                        userId: userId,
                        bankName: "Beli Voucher",
                        accountNumber: voucher['brand'],
                        amount: voucher['price'],
                        recipientName: voucher['name'],
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
      ),
    );
  }
}