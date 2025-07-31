import 'package:brimo_clone/data/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UbahPinPage extends StatefulWidget {
  const UbahPinPage({super.key});

  @override
  State<UbahPinPage> createState() => _UbahPinPageState();
}

class _UbahPinPageState extends State<UbahPinPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  bool _isLoading = false;

  Future<void> _changePin() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });

      try {
        // 1. Verifikasi PIN lama
        final userDoc = await _firestoreService.getUserData(userId);
        final currentPin = (userDoc.data() as Map<String, dynamic>)['pin'];

        if (currentPin != _oldPinController.text) {
          throw Exception("PIN lama salah.");
        }

        // 2. Simpan PIN baru
        await _firestoreService.updateUserPin(userId, _newPinController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("PIN berhasil diubah."), backgroundColor: Colors.green),
        );
        Navigator.pop(context);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengubah PIN: ${e.toString().replaceAll("Exception: ", "")}"), backgroundColor: Colors.red),
        );
      } finally {
        if (mounted) {
          setState(() { _isLoading = false; });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah PIN Transaksi"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _oldPinController,
                decoration: const InputDecoration(labelText: 'PIN Lama', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                validator: (value) => value!.isEmpty ? 'PIN lama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPinController,
                decoration: const InputDecoration(labelText: 'PIN Baru', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.length != 6) {
                    return 'PIN baru harus 6 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPinController,
                decoration: const InputDecoration(labelText: 'Konfirmasi PIN Baru', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                validator: (value) {
                  if (value != _newPinController.text) {
                    return 'Konfirmasi PIN tidak cocok';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Simpan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}