import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class CicilanPage extends StatefulWidget {
  final String userId;
  const CicilanPage({super.key, required this.userId});

  @override
  State<CicilanPage> createState() => _CicilanPageState();
}

class _CicilanPageState extends State<CicilanPage> {
  // --- PERBAIKAN DI SINI ---
  // Ubah dari String menjadi Map untuk menyimpan nama dan harga
  Map<String, dynamic>? _selectedCicilan;
  final _nomorKontrakController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Tambahkan harga untuk setiap jenis cicilan
  final List<Map<String, dynamic>> _jenisCicilan = [
    {'name': 'Cicilan Mobil', 'amount': 2500000},
    {'name': 'Cicilan Motor', 'amount': 850000},
    {'name': 'Kredit Tanpa Agunan', 'amount': 1200000},
    {'name': 'Kredit Rumah', 'amount': 4500000},
  ];

  void _onPay() {
    if (_formKey.currentState!.validate()) {
      // Ambil detail dari cicilan yang dipilih
      final String cicilanName = _selectedCicilan!['name'];
      final int cicilanAmount = _selectedCicilan!['amount'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransferConfirmationPage(
            userId: widget.userId,
            bankName: "Bayar Cicilan",
            accountNumber: _nomorKontrakController.text,
            amount: cicilanAmount, // Gunakan harga yang sesuai
            recipientName: cicilanName,
            adminFee: 5000,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran Cicilan"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/cicilan_illustration.png', // Pastikan path ini benar
                  height: 150,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Jenis Cicilan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // --- PERBAIKAN DI SINI ---
              DropdownButtonFormField<Map<String, dynamic>>(
                value: _selectedCicilan,
                hint: const Text('Pilih Jenis Cicilan'),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                // Tampilkan nama dari setiap Map
                items: _jenisCicilan.map((Map<String, dynamic> value) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: value,
                    child: Text(value['name']),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCicilan = newValue;
                  });
                },
                validator: (value) => value == null ? 'Pilih jenis cicilan' : null,
              ),
              const SizedBox(height: 24),
              const Text(
                "Nomor Pelanggan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nomorKontrakController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Nomor Pelanggan',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Nomor Pelanggan tidak boleh kosong' : null,
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