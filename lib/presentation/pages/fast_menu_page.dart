import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FastMenuPage extends StatefulWidget {
  const FastMenuPage({super.key});

  @override
  State<FastMenuPage> createState() => _FastMenuPageState();
}

class _FastMenuPageState extends State<FastMenuPage> {
  // Daftar semua menu yang tersedia
  final List<Map<String, dynamic>> _allMenus = [
    {'name': 'QRIS', 'icon': Icons.qr_code},
    {'name': 'BRIZZI', 'icon': Icons.credit_card},
    {'name': 'E-Wallet', 'icon': Icons.account_balance_wallet},
    {'name': 'BRIVA', 'icon': Icons.receipt},
    {'name': 'Transfer', 'icon': Icons.swap_horiz},
    {'name': 'Pulsa/Data', 'icon': Icons.phone_iphone},
    {'name': 'PLN', 'icon': Icons.electric_bolt},
  ];

  // List untuk menyimpan nama menu yang dipilih
  List<String> _selectedMenuNames = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSelectedMenus();
  }

  // Memuat menu yang sudah disimpan
  Future<void> _loadSelectedMenus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Jika belum ada yang disimpan, gunakan 5 menu default
      _selectedMenuNames = prefs.getStringList('fast_menus') ?? ['QRIS', 'BRIZZI', 'E-Wallet', 'BRIVA', 'Transfer'];
      _isLoading = false;
    });
  }

  // Menyimpan menu yang dipilih
  Future<void> _saveSelectedMenus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('fast_menus', _selectedMenuNames);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pengaturan berhasil disimpan."), backgroundColor: Colors.green)
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atur Fast Menu"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: _saveSelectedMenus,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _allMenus.length,
        itemBuilder: (context, index) {
          final menu = _allMenus[index];
          final isSelected = _selectedMenuNames.contains(menu['name']);

          return CheckboxListTile(
            title: Text(menu['name']),
            secondary: Icon(menu['icon']),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  // Batasi agar maksimal 5 menu yang bisa dipilih
                  if (_selectedMenuNames.length < 5) {
                    _selectedMenuNames.add(menu['name']);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Anda hanya bisa memilih maksimal 5 menu.")),
                    );
                  }
                } else {
                  _selectedMenuNames.remove(menu['name']);
                }
              });
            },
          );
        },
      ),
    );
  }
}