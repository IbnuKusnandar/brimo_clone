import 'package:brimo_clone/presentation/pages/buka_rekening_confirmation_page.dart';
import 'package:flutter/material.dart';

class BukaRekeningFormPage extends StatefulWidget {
  final String userId; // <-- Tambahkan ini
  final String productName;
  const BukaRekeningFormPage({super.key, required this.userId, required this.productName}); // <-- Ubah ini

  @override
  State<BukaRekeningFormPage> createState() => _BukaRekeningFormPageState();
}

class _BukaRekeningFormPageState extends State<BukaRekeningFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _ktpController = TextEditingController();
  final _npwpController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BukaRekeningConfirmationPage(
            userId: widget.userId, // <-- Tambahkan ini
            productName: widget.productName,
            fullName: _fullNameController.text,
            ktpNumber: _ktpController.text,
            npwpNumber: _npwpController.text,
            email: _emailController.text,
            phoneNumber: _phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Buka Rekening ${widget.productName}"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap Sesuai KTP',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ktpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor KTP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Nomor KTP tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _npwpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor NPWP (Opsional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Email tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Ponsel',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Nomor ponsel tidak boleh kosong' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Lanjutkan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}