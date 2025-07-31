import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailPage extends StatelessWidget {
  final String userId;
  final Map<String, String> eventData;

  const EventDetailPage({super.key, required this.userId, required this.eventData});

  @override
  Widget build(BuildContext context) {
    final int ticketPrice = int.parse(eventData['price']!);
    final currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(eventData['name']!),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              eventData['image']!,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventData['name']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.calendar_today, eventData['date']!),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.location_on, eventData['location']!),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.confirmation_number, "Harga: ${currencyFormatter.format(ticketPrice)}"),
                  const SizedBox(height: 24),
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    eventData['description']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransferConfirmationPage(
                  userId: userId,
                  bankName: "Tiket Event",
                  accountNumber: eventData['name']!,
                  amount: ticketPrice,
                  recipientName: "Pembelian Tiket",
                  adminFee: 1500,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          ),
          child: const Text("Beli Tiket Sekarang", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}