import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BeliObatPage extends StatefulWidget {
  final String userId;
  const BeliObatPage({super.key, required this.userId});

  @override
  State<BeliObatPage> createState() => _BeliObatPageState();
}

class _BeliObatPageState extends State<BeliObatPage> {
  // Daftar semua obat dengan harga
  final List<Map<String, dynamic>> _allObat = [
    {'name': 'Paracetamol 500mg', 'price': 8000},
    {'name': 'Amoxicillin 250mg', 'price': 15000},
    {'name': 'Vitamin C IPI', 'price': 12000},
    {'name': 'Bodrex', 'price': 7500},
    {'name': 'Panadol Biru', 'price': 9000},
    {'name': 'OBH Combi Batuk Flu', 'price': 18000},
    {'name': 'Tolak Angin Cair', 'price': 4000},
    {'name': 'Mylanta Cair', 'price': 15000},
    {'name': 'Betadine Antiseptic', 'price': 25000},
    {'name': 'Insto Tetes Mata', 'price': 17000},
    {'name': 'Sangobion', 'price': 22000},
    {'name': 'Diapet', 'price': 10000},
  ];

  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = _allObat;
  }

  void _searchObat(String query) {
    final results = _allObat.where((obat) {
      final obatLower = (obat['name'] as String).toLowerCase();
      final queryLower = query.toLowerCase();
      return obatLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beli Obat"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _searchObat,
              decoration: const InputDecoration(
                labelText: 'Cari Obat atau Vitamin',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(child: Text("Obat tidak ditemukan.", style: TextStyle(color: Colors.grey[600])))
                  : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final obat = _searchResults[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(obat['name']),
                      subtitle: Text(currencyFormatter.format(obat['price'])),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // --- FUNGSI BELI DI SINI ---
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransferConfirmationPage(
                                userId: widget.userId,
                                bankName: "Pembelian Obat",
                                accountNumber: obat['name'],
                                amount: obat['price'],
                                recipientName: "Apotek BRImo",
                                adminFee: 2000, // Contoh biaya admin
                              ),
                            ),
                          );
                        },
                        child: const Text("Beli"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}