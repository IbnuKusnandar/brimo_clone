import 'package:brimo_clone/presentation/pages/main_screen.dart';
import 'package:brimo_clone/presentation/pages/registration_success_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? newUser = userCredential.user;

        if (newUser != null) {
          // Simpan data utama pengguna
          await _firestore.collection('users').doc(newUser.uid).set({
            'uid': newUser.uid,
            'name': _nameController.text.trim(),
            'email': _emailController.text.trim(),
            'balance': 10000000,
            'createdAt': Timestamp.now(),
          });

          // Buat "Rekening Utama" di sub-koleksi accounts
          await _firestore.collection('users').doc(newUser.uid).collection('accounts').add({
            'name': 'Rekening Utama',
            'number': '0820 0101 4099 500',
            'balance': 10000000,
          });

          // Buat data kartu default untuk pengguna baru
          final cardsCollection = _firestore.collection('users').doc(newUser.uid).collection('cards');

          await cardsCollection.add({
            'type': 'Kartu Debit',
            'number': '**** **** **** 0500',
            'isBlocked': false,
          });

          await cardsCollection.add({
            'type': 'Kartu Kredit',
            'number': '**** **** **** 5678',
            'isBlocked': true,
          });

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegistrationSuccessPage(userId: newUser.uid)),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Terjadi kesalahan saat pendaftaran.';
        if (e.code == 'weak-password') {
          message = 'Password yang dimasukkan terlalu lemah.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Akun dengan email ini sudah terdaftar.';
        } else if (e.code == 'invalid-email') {
          message = 'Format email tidak valid.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if(mounted){
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun Baru'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/registration.json', width: 150),
                const SizedBox(height: 20),
                const Text(
                  "Selamat Datang!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00529B)),
                ),
                const Text(
                  "Silakan isi data diri Anda untuk melanjutkan.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty || !value.contains('@') ? 'Masukkan email yang valid' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) => value!.isEmpty || value.length < 6 ? 'Password minimal harus 6 karakter' : null,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Daftar', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}