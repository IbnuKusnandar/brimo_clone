import 'package:flutter/material.dart';

class BahasaPage extends StatefulWidget {
  const BahasaPage({super.key});

  @override
  State<BahasaPage> createState() => _BahasaPageState();
}

class _BahasaPageState extends State<BahasaPage> {
  String _selectedLanguage = 'Indonesia'; // Bahasa default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Bahasa"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Bahasa berhasil diubah ke $_selectedLanguage"))
              );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        children: [
          RadioListTile<String>(
            title: const Text('Indonesia'),
            value: 'Indonesia',
            groupValue: _selectedLanguage,
            onChanged: (String? value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('English'),
            value: 'English',
            groupValue: _selectedLanguage,
            onChanged: (String? value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}