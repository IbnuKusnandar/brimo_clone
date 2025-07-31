import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransferInputPage extends StatefulWidget {
  final String userId;
  final Map<String, String> selectedBank;
  const TransferInputPage({super.key, required this.selectedBank, required this.userId});

  @override
  State<TransferInputPage> createState() => _TransferInputPageState();
}

class _TransferInputPageState extends State<TransferInputPage> {
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer ke ${widget.selectedBank['name']}"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _accountController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Rekening Tujuan',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor rekening tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Nominal Transfer',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nominal tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 10000) {
                    return 'Minimal transfer Rp 10.000';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransferConfirmationPage(
                            userId: widget.userId, // Teruskan userId
                            bankName: widget.selectedBank['name']!,
                            accountNumber: _accountController.text,
                            amount: int.parse(_amountController.text),
                            recipientName: "Rintisms",
                            adminFee: 6500,
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
      ),
    );
  }
}