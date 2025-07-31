import 'package:brimo_clone/presentation/pages/kartu_kredit_payment_page.dart';
import 'package:flutter/material.dart';

class KartuKreditBankPage extends StatelessWidget {
  final String userId;
  const KartuKreditBankPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Daftar bank contoh
    final List<String> banks = [
      'Bank BRI',
      'Bank BCA',
      'Bank Mandiri',
      'Bank BNI',
      'CIMB Niaga',
      'Citibank',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Bank Penerbit"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: banks.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(banks[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KartuKreditPaymentPage(
                    userId: userId,
                    bankName: banks[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}