import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class BrivaPage extends StatefulWidget {
  final String userId;
  const BrivaPage({super.key, required this.userId});

  @override
  State<BrivaPage> createState() => _BrivaPageState();
}

class _BrivaPageState extends State<BrivaPage> {
  final _brivaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran BRIVA"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _brivaController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nomor BRIVA',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_brivaController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferConfirmationPage(
                          userId: widget.userId,
                          bankName: "BRIVA",
                          accountNumber: _brivaController.text,
                          amount: 50000,
                          recipientName: "Tagihan Internet",
                          adminFee: 2500,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Lanjutkan", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}