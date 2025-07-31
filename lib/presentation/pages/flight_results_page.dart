import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightResultsPage extends StatelessWidget {
  final String userId;
  final String fromCity;
  final String toCity;
  final DateTime date;

  const FlightResultsPage({
    super.key,
    required this.userId,
    required this.fromCity,
    required this.toCity,
    required this.date,
  });

  // --- FUNGSI BARU UNTUK MENGHASILKAN HARGA BERDASARKAN RUTE ---
  List<Map<String, dynamic>> _generateFlights() {
    // Peta harga dasar untuk setiap rute
    final Map<String, int> basePrices = {
      'Jakarta (CGK)-Bali (DPS)': 1200000,
      'Jakarta (CGK)-Surabaya (SUB)': 800000,
      'Surabaya (SUB)-Bali (DPS)': 600000,
      'Jakarta (CGK)-Medan (KNO)': 1500000,
    };

    // Cari harga dasar, jika tidak ada, gunakan harga default
    final routeKey = '$fromCity-$toCity';
    final reverseRouteKey = '$toCity-$fromCity';
    final basePrice = basePrices[routeKey] ?? basePrices[reverseRouteKey] ?? 900000;

    // Buat daftar penerbangan dengan variasi harga
    return [
      {'airline': 'Garuda Indonesia', 'time': '07:00 - 09:00', 'price': basePrice + 200000},
      {'airline': 'Citilink', 'time': '08:30 - 10:30', 'price': basePrice - 50000},
      {'airline': 'Lion Air', 'time': '09:00 - 11:00', 'price': basePrice - 150000},
      {'airline': 'Batik Air', 'time': '11:00 - 13:00', 'price': basePrice + 100000},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final flights = _generateFlights();
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$fromCity -> $toCity", style: const TextStyle(fontSize: 16)),
            Text(DateFormat('dd MMMM yyyy').format(date), style: const TextStyle(fontSize: 12)),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: flights.length,
        itemBuilder: (context, index) {
          final flight = flights[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.flight_takeoff, color: Theme.of(context).primaryColor),
              title: Text(flight['airline'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Jadwal: ${flight['time']}"),
              trailing: Text(
                currencyFormatter.format(flight['price']),
                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TransferConfirmationPage(
                  userId: userId,
                  bankName: "Tiket Pesawat",
                  accountNumber: flight['airline'],
                  amount: flight['price'],
                  recipientName: "$fromCity -> $toCity",
                )));
              },
            ),
          );
        },
      ),
    );
  }
}