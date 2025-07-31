import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaketDataPage extends StatefulWidget {
  final String userId;
  // Hapus 'const' dari constructor
  const PaketDataPage({super.key, required this.userId});

  @override
  State<PaketDataPage> createState() => _PaketDataPageState();
}

class _PaketDataPageState extends State<PaketDataPage> {
  final _phoneController = TextEditingController();

  void _onNominalTap(int amount, String packageName) {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nomor ponsel tidak boleh kosong"), backgroundColor: Colors.red),
      );
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransferConfirmationPage(
              userId: widget.userId,
              bankName: "Paket Data",
              accountNumber: _phoneController.text,
              amount: amount,
              recipientName: packageName,
              adminFee: 1500,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beli Paket Data"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor Ponsel',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildNominalButton("10 GB", 50000),
                  _buildNominalButton("25 GB", 100000),
                  _buildNominalButton("50 GB", 150000),
                  _buildNominalButton("100 GB", 250000),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNominalButton(String text, int amount) {
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return ElevatedButton(
        onPressed: () => _onNominalTap(amount, text),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade300)),
            padding: const EdgeInsets.symmetric(vertical: 16)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              currencyFormatter.format(amount),
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        )
    );
  }
}