import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class DanaPage extends StatelessWidget {
  final String userId;
  const DanaPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    void _onContinue(int amount) {
      if (phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nomor ponsel tidak boleh kosong"), backgroundColor: Colors.red));
        return;
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => TransferConfirmationPage(
        userId: userId,
        bankName: "Top Up DANA",
        accountNumber: phoneController.text,
        amount: amount,
        recipientName: "DANA Customer",
      )));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Up DANA"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor Ponsel Terdaftar',
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
                  ElevatedButton(onPressed: () => _onContinue(25000), child: const Text("Rp 25.000")),
                  ElevatedButton(onPressed: () => _onContinue(50000), child: const Text("Rp 50.000")),
                  ElevatedButton(onPressed: () => _onContinue(100000), child: const Text("Rp 100.000")),
                  ElevatedButton(onPressed: () => _onContinue(200000), child: const Text("Rp 200.000")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}