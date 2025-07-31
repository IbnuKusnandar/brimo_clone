import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class PdamInputPage extends StatefulWidget {
  final String userId;
  final String selectedRegion;
  const PdamInputPage({super.key, required this.userId, required this.selectedRegion});

  @override
  State<PdamInputPage> createState() => _PdamInputPageState();
}

class _PdamInputPageState extends State<PdamInputPage> {
  final _customerIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      // Simulasi data tagihan dari nomor pelanggan
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransferConfirmationPage(
            userId: widget.userId,
            bankName: "Tagihan PDAM",
            accountNumber: _customerIdController.text,
            amount: 150000, // Contoh nominal tagihan
            recipientName: widget.selectedRegion,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedRegion),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Masukkan Nomor Pelanggan PDAM Anda:", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _customerIdController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Pelanggan',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor pelanggan tidak boleh kosong';
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
                  child: const Text("Lanjutkan", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}