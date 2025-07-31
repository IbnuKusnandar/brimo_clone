import 'package:brimo_clone/presentation/pages/flight_results_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TiketPesawatPage extends StatefulWidget {
  final String userId;
  const TiketPesawatPage({super.key, required this.userId});

  @override
  State<TiketPesawatPage> createState() => _TiketPesawatPageState();
}

class _TiketPesawatPageState extends State<TiketPesawatPage> {
  String _kotaAsal = 'Jakarta (CGK)';
  String _kotaTujuan = 'Bali (DPS)';
  DateTime _tanggalBerangkat = DateTime.now();

  final List<String> _kotaList = [
    'Jakarta (CGK)',
    'Bali (DPS)',
    'Surabaya (SUB)',
    'Medan (KNO)',
    'Makassar (UPG)',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalBerangkat,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _tanggalBerangkat) {
      setState(() {
        _tanggalBerangkat = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan Tiket Pesawat"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildCityDropdown("Kota Asal", _kotaAsal, (val) => setState(() => _kotaAsal = val!)),
            const SizedBox(height: 16),
            _buildCityDropdown("Kota Tujuan", _kotaTujuan, (val) => setState(() => _kotaTujuan = val!)),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: const Text("Tanggal Keberangkatan"),
              subtitle: Text(DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(_tanggalBerangkat)),
              onTap: () => _selectDate(context),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_kotaAsal == _kotaTujuan) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Kota asal dan tujuan tidak boleh sama."), backgroundColor: Colors.red),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlightResultsPage(
                        userId: widget.userId, // Meneruskan userId
                        fromCity: _kotaAsal,
                        toCity: _kotaTujuan,
                        date: _tanggalBerangkat,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Cari Penerbangan", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDropdown(String label, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: _kotaList.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}