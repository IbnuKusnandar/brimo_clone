import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrainSchedulePage extends StatelessWidget {
  final String userId;
  final String fromStation;
  final String toStation;
  final DateTime date;

  const TrainSchedulePage({
    super.key,
    required this.userId,
    required this.fromStation,
    required this.toStation,
    required this.date,
  });

  // --- FUNGSI BARU UNTUK MENGHASILKAN HARGA BERDASARKAN RUTE ---
  List<Map<String, dynamic>> _generateSchedules() {
    // Peta harga dasar untuk setiap rute
    final Map<String, int> basePrices = {
      'Bandung-Gambir': 150000,
      'Bandung-Surabaya': 450000,
      'Gambir-Yogyakarta': 350000,
      'Yogyakarta-Surabaya': 250000,
    };

    // Cari harga dasar, jika tidak ada, gunakan harga default
    final routeKey = '$fromStation-$toStation';
    final reverseRouteKey = '$toStation-$fromStation';
    final basePrice = basePrices[routeKey] ?? basePrices[reverseRouteKey] ?? 300000;

    // Buat daftar jadwal dengan variasi harga
    return [
      {'name': 'Argo Parahyangan', 'time': '08:00 - 11:00', 'price': basePrice, 'class': 'Ekonomi'},
      {'name': 'Argo Wilis', 'time': '10:30 - 13:30', 'price': (basePrice * 1.5).toInt(), 'class': 'Eksekutif'},
      {'name': 'Serayu', 'time': '14:00 - 17:30', 'price': basePrice - 50000, 'class': 'Ekonomi'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final schedules = _generateSchedules();
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$fromStation -> $toStation", style: const TextStyle(fontSize: 16)),
            Text(DateFormat('dd MMMM yyyy', 'id_ID').format(date), style: const TextStyle(fontSize: 12)),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(schedule['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${schedule['class']} | ${schedule['time']}"),
              trailing: Text(
                currencyFormatter.format(schedule['price']),
                style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferConfirmationPage(
                      userId: userId,
                      bankName: "KAI Commuter Line",
                      accountNumber: schedule['name'],
                      amount: schedule['price'],
                      recipientName: "$fromStation -> $toStation",
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}