import 'package:brimo_clone/presentation/pages/main_screen.dart';
import 'package:brimo_clone/presentation/pages/qris_scanner_page.dart';
import 'package:brimo_clone/presentation/pages/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final Map<String, IconData> _menuIcons = {
    'QRIS': Icons.qr_code,
    'BRIZZI': Icons.credit_card,
    'E-Wallet': Icons.account_balance_wallet,
    'BRIVA': Icons.receipt,
    'Transfer': Icons.swap_horiz,
    'Pulsa/Data': Icons.phone_iphone,
    'PLN': Icons.electric_bolt,
  };
  List<String> _fastMenusToDisplay = [];

  @override
  void initState() {
    super.initState();
    _loadFastMenus();
  }

  Future<void> _loadFastMenus() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _fastMenusToDisplay = prefs.getStringList('fast_menus') ?? ['QRIS', 'BRIZZI', 'E-Wallet', 'BRIVA', 'Transfer'];
      });
    }
  }

  void _handleFastMenuTap(String menu) {
    if (menu == "QRIS") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const QrisScannerPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Silakan login untuk menggunakan fitur $menu")),
      );
    }
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Email dan Password tidak boleh kosong."),
            backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? user = userCredential.user;
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.uid);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(userId: user.uid),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login Gagal. Periksa kembali email dan password Anda.";
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = 'Email atau password yang Anda masukkan salah.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- GAMBAR LATAR BELAKANG ---
          Image.asset(
            'assets/images/background.png', // Pastikan path ini benar
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          // --- KONTEN LOGIN ---
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/login_screen.json',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Login",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00529B)),
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00529B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Login', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                        );
                      },
                      child: const Text("Belum punya akun? Daftar di sini"),
                    ),
                    const SizedBox(height: 40),
                    const Divider(),
                    const SizedBox(height: 20),
                    const Text("Fast Menu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    _buildFastMenu(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFastMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _fastMenusToDisplay.map((menuName) {
          final icon = _menuIcons[menuName] ?? Icons.error;
          return _fastMenuItem(icon, menuName);
        }).toList(),
      ),
    );
  }

  Widget _fastMenuItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () => _handleFastMenuTap(label),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: const Color(0xFF00529B), size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}