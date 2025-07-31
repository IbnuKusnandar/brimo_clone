import 'package:flutter/material.dart';

class SumberDanaQrisPage extends StatefulWidget {
  const SumberDanaQrisPage({super.key});

  @override
  State<SumberDanaQrisPage> createState() => _SumberDanaQrisPageState();
}

class _SumberDanaQrisPageState extends State<SumberDanaQrisPage> {
  // Simulasikan rekening yang terpilih
  String _selectedAccount = '0820 0101 4099 500';

  final List<Map<String, String>> _accounts = [
    {'name': 'Rekening Utama', 'number': '0820 0101 4099 500'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sumber Dana QRIS"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pengaturan berhasil disimpan."))
              );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _accounts.length,
        itemBuilder: (context, index) {
          final account = _accounts[index];
          return RadioListTile<String>(
            title: Text(account['name']!),
            subtitle: Text(account['number']!),
            value: account['number']!,
            groupValue: _selectedAccount,
            onChanged: (String? value) {
              setState(() {
                _selectedAccount = value!;
              });
            },
          );
        },
      ),
    );
  }
}