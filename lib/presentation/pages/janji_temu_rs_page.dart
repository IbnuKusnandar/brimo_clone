import 'package:brimo_clone/presentation/pages/janji_temu_history_page.dart';
import 'package:brimo_clone/presentation/pages/janji_temu_success_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JanjiTemuRsPage extends StatefulWidget {
  const JanjiTemuRsPage({super.key});

  @override
  State<JanjiTemuRsPage> createState() => _JanjiTemuRsPageState();
}

class _JanjiTemuRsPageState extends State<JanjiTemuRsPage> {
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, String>> _doctorSchedules = [
    {
      'name': 'Dr. Budi Santoso',
      'specialty': 'Dokter Umum',
      'time': '09:00 - 11:00',
    },
    {
      'name': 'Dr. Siti Aminah',
      'specialty': 'Dokter Anak',
      'time': '13:00 - 15:00',
    },
    {
      'name': 'Dr. Agus Wijaya',
      'specialty': 'Penyakit Dalam',
      'time': '16:00 - 18:00',
    },
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Janji Temu"),
        backgroundColor: Theme.of(context).primaryColor,
        // --- PERUBAHAN DI SINI ---
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JanjiTemuHistoryPage()),
              );
            },
            icon: const Icon(Icons.history),
            tooltip: "Riwayat Janji Temu",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              title: const Text("Pilih Tanggal Janji Temu"),
              subtitle: Text(DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(_selectedDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 24),
            const Text("Jadwal Tersedia", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _doctorSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = _doctorSchedules[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.person, size: 40, color: Theme.of(context).primaryColor),
                      title: Text(schedule['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("${schedule['specialty']}\nJam: ${schedule['time']}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JanjiTemuSuccessPage(
                                doctorName: schedule['name']!,
                                specialty: schedule['specialty']!,
                                time: schedule['time']!,
                                date: DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate),
                              ),
                            ),
                          );
                        },
                        child: const Text("Pilih"),
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