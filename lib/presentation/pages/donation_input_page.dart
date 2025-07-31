import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class DonationInputPage extends StatefulWidget {
  final String userId;
  final String donationType;
  final String institutionName;

  // --- PERBAIKAN DI SINI ---
  // Hapus 'const' dari constructor
  const DonationInputPage({
    super.key,
    required this.userId,
    required this.donationType,
    required this.institutionName,
  });

  @override
  State<DonationInputPage> createState() => _DonationInputPageState();
}

class _DonationInputPageState extends State<DonationInputPage> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransferConfirmationPage(
            userId: widget.userId,
            bankName: widget.donationType,
            accountNumber: widget.institutionName,
            amount: int.parse(_amountController.text),
            recipientName: "Pembayaran ${widget.donationType}",
            adminFee: 0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.donationType),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lembaga: ${widget.institutionName}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Masukkan Nominal ${widget.donationType}',
                  border: const OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nominal tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Masukkan nominal yang valid';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                  child: const Text("Lanjutkan",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}