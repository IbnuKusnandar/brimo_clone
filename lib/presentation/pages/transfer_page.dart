import 'package:brimo_clone/presentation/pages/transfer_input_page.dart';
import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  final String userId;
  const TransferPage({super.key, required this.userId});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final List<Map<String, String>> banks = [
    {'name': 'Bank BRI', 'logo': 'assets/images/logo.png'},
    {'name': 'Bank BCA', 'logo': 'assets/images/logobca.png'},
    {'name': 'Bank Mandiri', 'logo': 'assets/images/logomandiri.png'},
    {'name': 'Bank BNI', 'logo': 'assets/images/logobni.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PASTIKAN ADA AppBar DI SINI
      appBar: AppBar(
        title: const Text("Pilih Bank Tujuan"),
        backgroundColor: Theme.of(context).primaryColor,
        // Tombol kembali akan muncul otomatis di sini
        // karena halaman ini diakses menggunakan Navigator.push()
      ),
      body: ListView.builder(
        itemCount: banks.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Image.asset(banks[index]['logo']!, width: 40),
                title: Text(banks[index]['name']!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferInputPage(
                        userId: widget.userId,
                        selectedBank: banks[index],
                      ),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}