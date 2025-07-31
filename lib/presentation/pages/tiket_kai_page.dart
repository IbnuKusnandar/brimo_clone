import 'package:brimo_clone/presentation/pages/train_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TiketKaiPage extends StatefulWidget {
  final String userId;
  const TiketKaiPage({super.key, required this.userId});

  @override
  State<TiketKaiPage> createState() => _TiketKaiPageState();
}

class _TiketKaiPageState extends State<TiketKaiPage> {
  String _stasiunAsal = 'Bandung';
  String _stasiunTujuan = 'Gambir';
  DateTime _selectedDate = DateTime.now();

  final List<String> _stasiunList = [
    'Bandung',
    'Gambir',
    'Surabaya',
    'Yogyakarta',
    'Semarang',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _swapStations() {
    setState(() {
      final temp = _stasiunAsal;
      _stasiunAsal = _stasiunTujuan;
      _stasiunTujuan = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan Tiket Kereta Api"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildStationDropdown("Asal", _stasiunAsal, (val) => setState(() => _stasiunAsal = val!))),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(onPressed: _swapStations, icon: const Icon(Icons.swap_horiz)),
                ),
                Expanded(child: _buildStationDropdown("Tujuan", _stasiunTujuan, (val) => setState(() => _stasiunTujuan = val!))),
              ],
            ),
            const SizedBox(height: 20),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: const Text("Tanggal Keberangkatan"),
              subtitle: Text(DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(_selectedDate)),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: () => _selectDate(context),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_stasiunAsal == _stasiunTujuan) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Stasiun asal dan tujuan tidak boleh sama."), backgroundColor: Colors.red),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainSchedulePage(
                        userId: widget.userId, // Meneruskan userId
                        fromStation: _stasiunAsal,
                        toStation: _stasiunTujuan,
                        date: _selectedDate,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Cari Tiket", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationDropdown(String label, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      items: _stasiunList.map((String station) {
        return DropdownMenuItem<String>(
          value: station,
          child: Text(station, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}