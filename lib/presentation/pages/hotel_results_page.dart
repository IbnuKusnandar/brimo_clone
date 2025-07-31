import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelResultsPage extends StatelessWidget {
  final String userId;
  final String destination;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  const HotelResultsPage({
    super.key,
    required this.userId,
    required this.destination,
    required this.checkInDate,
    required this.checkOutDate,
  });

  // --- FUNGSI PENCARIAN DIPERBARUI DI SINI ---
  List<Map<String, dynamic>> _getResults(String query) {
    final lowerCaseQuery = query.toLowerCase();

    // Data lengkap semua hotel di semua kota
    final Map<String, List<Map<String, dynamic>>> allHotelData = {
      'jakarta': [
        {'name': 'Hotel Indonesia Kempinski', 'rating': 4.9, 'price': 2500000, 'image': 'assets/images/hotel_jakarta.jpg'},
        {'name': 'The Ritz-Carlton Jakarta', 'rating': 4.8, 'price': 3000000, 'image': 'assets/images/hotel_jakarta2.jpg'},
      ],
      'bali': [
        {'name': 'The Mulia Resort & Villas', 'rating': 4.9, 'price': 4500000, 'image': 'assets/images/hotel_bali.jpg'},
        {'name': 'AYANA Resort and Spa', 'rating': 4.8, 'price': 3800000, 'image': 'assets/images/hotel_bali2.jpg'},
      ],
      'surabaya': [
        {'name': 'JW Marriott Hotel Surabaya', 'rating': 4.7, 'price': 1800000, 'image': 'assets/images/hotel_surabaya.jpg'},
        {'name': 'Shangri-La Hotel Surabaya', 'rating': 4.8, 'price': 2200000, 'image': 'assets/images/hotel_surabaya2.jpg'},
      ],
      'makassar': [
        {'name': 'The Rinra Makassar', 'rating': 4.6, 'price': 1200000, 'image': 'assets/images/hotel_makassar.jpg'},
      ],
      'bandung': [
        {'name': 'Grand Hotel Preanger', 'rating': 4.5, 'price': 850000, 'image': 'assets/images/hotel_bandung.jpg'},
        {'name': 'The Trans Luxury Hotel', 'rating': 4.8, 'price': 1500000, 'image': 'assets/images/hotel_bandung2.jpg'},
        {'name': 'GH Universal Hotel', 'rating': 4.6, 'price': 950000, 'image': 'assets/images/hotel_bandung3.jpg'},
      ],
    };

    // 1. Cek apakah query cocok dengan nama kota
    if (allHotelData.containsKey(lowerCaseQuery)) {
      return allHotelData[lowerCaseQuery]!;
    }

    // 2. Jika tidak, cari berdasarkan nama hotel di semua kota
    List<Map<String, dynamic>> foundHotels = [];
    allHotelData.forEach((city, hotels) {
      for (var hotel in hotels) {
        if (hotel['name'].toLowerCase().contains(lowerCaseQuery)) {
          foundHotels.add(hotel);
        }
      }
    });

    // 3. Jika ditemukan hotel, kembalikan hasilnya
    if (foundHotels.isNotEmpty) {
      return foundHotels;
    }

    // 4. Jika tidak ada yang cocok sama sekali, kembalikan list kosong
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final hotels = _getResults(destination);
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(destination, style: const TextStyle(fontSize: 16)),
            Text(
                "${DateFormat('dd MMM').format(checkInDate)} - ${DateFormat('dd MMM yyyy').format(checkOutDate)}",
                style: const TextStyle(fontSize: 12)
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // --- PERBAIKAN DI SINI ---
      // Tampilkan pesan "Tidak ada hotel ditemukan" jika list kosong
      body: hotels.isEmpty
          ? const Center(child: Text("Hotel Tidak Ditemukan Untuk Kota Ini."))
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Image.asset(hotel['image'], height: 180, width: double.infinity, fit: BoxFit.cover),
                ListTile(
                  title: Text(hotel['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(" ${hotel['rating']}"),
                    ],
                  ),
                  trailing: Text(
                    "${currencyFormatter.format(hotel['price'])} / malam",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TransferConfirmationPage(
                          userId: userId,
                          bankName: "Pesan Hotel",
                          accountNumber: hotel['name'],
                          amount: hotel['price'],
                          recipientName: "Booking Hotel",
                        )));
                      },
                      child: const Text("Pesan Sekarang"),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}