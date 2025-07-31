import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class PulsaDataPage extends StatefulWidget {
  final String userId;
  const PulsaDataPage({super.key, required this.userId});

  @override
  State<PulsaDataPage> createState() => _PulsaDataPageState();
}

class _PulsaDataPageState extends State<PulsaDataPage> {
  final _phoneController = TextEditingController();

  void _onNominalTap(int amount) {
    if (_phoneController.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TransferConfirmationPage(
                userId: widget.userId,
                bankName: "Pulsa",
                accountNumber: _phoneController.text,
                amount: amount,
                recipientName: "Telkomsel (Contoh)",
                adminFee: 1500,
              )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nomor ponsel tidak boleh kosong"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beli Pulsa/Data"),
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
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildNominalButton("Rp 25.000", 25000),
                  _buildNominalButton("Rp 50.000", 50000),
                  _buildNominalButton("Rp 100.000", 100000),
                  _buildNominalButton("Rp 200.000", 200000),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNominalButton(String text, int amount) {
    return ElevatedButton(
      onPressed: () => _onNominalTap(amount),
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade300))),
      child: Text(text),
    );
  }
}