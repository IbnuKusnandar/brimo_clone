import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class KartuKreditPaymentPage extends StatefulWidget {
  final String userId;
  final String bankName;

  const KartuKreditPaymentPage({
    super.key,
    required this.userId,
    required this.bankName,
  });

  @override
  State<KartuKreditPaymentPage> createState() => _KartuKreditPaymentPageState();
}

class _KartuKreditPaymentPageState extends State<KartuKreditPaymentPage> {
  final _cardNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onPay() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransferConfirmationPage(
            userId: widget.userId,
            bankName: "Bayar Kartu Kredit",
            accountNumber: _cardNumberController.text,
            amount: int.parse(_amountController.text),
            recipientName: widget.bankName,
            adminFee: 2500,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bayar Kartu Kredit ${widget.bankName}"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Kartu Kredit',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Nomor kartu tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Nominal Pembayaran',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Nominal tidak boleh kosong' : null,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Bayar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}