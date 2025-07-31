import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterBottomSheet extends StatefulWidget {
  final DateTime initialStartDate;
  final DateTime initialEndDate;

  const FilterBottomSheet({
    super.key,
    required this.initialStartDate,
    required this.initialEndDate,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late DateTime _startDate;
  late DateTime _endDate;
  String _transactionType = 'Semua';

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Filter Transaksi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Filter Tanggal
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, true),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Tanggal Awal', border: OutlineInputBorder()),
                    child: Text(DateFormat('dd MMM yyyy').format(_startDate)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, false),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Tanggal Akhir', border: OutlineInputBorder()),
                    child: Text(DateFormat('dd MMM yyyy').format(_endDate)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Filter Jenis Transaksi
          DropdownButtonFormField<String>(
            value: _transactionType,
            decoration: const InputDecoration(labelText: 'Jenis Transaksi', border: OutlineInputBorder()),
            items: ['Semua', 'Uang Masuk', 'Uang Keluar'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _transactionType = newValue!;
              });
            },
          ),
          const SizedBox(height: 30),

          // Tombol Terapkan
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Kembalikan data filter ke halaman sebelumnya
                Navigator.pop(context, {
                  'startDate': _startDate,
                  'endDate': _endDate,
                  'type': _transactionType,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Terapkan"),
            ),
          )
        ],
      ),
    );
  }
}