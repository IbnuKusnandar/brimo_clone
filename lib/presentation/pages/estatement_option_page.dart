import 'package:brimo_clone/presentation/pages/estatement_view_page.dart';
import 'package:flutter/material.dart';

class EStatementOptionPage extends StatefulWidget {
  final String userId;
  const EStatementOptionPage({super.key, required this.userId});

  @override
  State<EStatementOptionPage> createState() => _EStatementOptionPageState();
}

class _EStatementOptionPageState extends State<EStatementOptionPage> {
  String _selectedMonth = 'Juli';
  String _selectedYear = '2025';

  final List<String> _months = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  final List<String> _years = ['2023', '2024', '2025'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat e-Statement"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Periode Laporan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedMonth,
              decoration: const InputDecoration(
                labelText: 'Bulan',
                border: OutlineInputBorder(),
              ),
              items: _months.map((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedMonth = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedYear,
              decoration: const InputDecoration(
                labelText: 'Tahun',
                border: OutlineInputBorder(),
              ),
              items: _years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedYear = newValue!;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EStatementViewPage(
                        userId: widget.userId,
                        month: _months.indexOf(_selectedMonth) + 1,
                        year: int.parse(_selectedYear),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    )
                ),
                child: const Text("Lihat e-Statement", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}