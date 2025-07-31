import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          throw Exception("Anda harus login ulang untuk melakukan aksi ini.");
        }

        // Re-autentikasi pengguna dengan password lama
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _oldPasswordController.text,
        );
        await user.reauthenticateWithCredential(credential);

        // Jika berhasil, update password baru
        await user.updatePassword(_newPasswordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password berhasil diubah."), backgroundColor: Colors.green),
        );
        Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        String message = "Gagal mengubah password.";
        if (e.code == 'wrong-password') {
          message = "Password lama yang Anda masukkan salah.";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Terjadi kesalahan: $e"), backgroundColor: Colors.red),
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
        title: const Text("Ubah Password Login"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _oldPasswordController,
                decoration: const InputDecoration(labelText: 'Password Lama', border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Password lama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'Password Baru', border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password baru minimal harus 6 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Konfirmasi Password Baru', border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Konfirmasi password tidak cocok';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
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