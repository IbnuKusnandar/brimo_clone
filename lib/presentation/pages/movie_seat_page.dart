import 'package:brimo_clone/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';

class MovieSeatPage extends StatefulWidget {
  final String userId;
  final String movieTitle;
  final String cinemaName;
  final String selectedTime;
  const MovieSeatPage({super.key, required this.userId, required this.movieTitle, required this.cinemaName, required this.selectedTime});

  @override
  State<MovieSeatPage> createState() => _MovieSeatPageState();
}

class _MovieSeatPageState extends State<MovieSeatPage> {
  final Set<String> _bookedSeats = {'A3', 'C5', 'D1', 'D2'};
  final Set<String> _selectedSeats = {};
  final int _ticketPrice = 50000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.cinemaName} - ${widget.selectedTime}"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Text("Layar Bioskop", style: TextStyle(fontSize: 16, color: Colors.grey)),
          const Divider(thickness: 2, indent: 20, endIndent: 20),
          const SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 48,
                itemBuilder: (context, index) {
                  if (index % 8 == 3 || index % 8 == 4) {
                    return const SizedBox.shrink();
                  }

                  final row = String.fromCharCode(65 + (index ~/ 8));
                  int seatNum = (index % 8) + 1;
                  if (seatNum > 4) seatNum -= 2;
                  final seatId = '$row$seatNum';

                  final isBooked = _bookedSeats.contains(seatId);
                  final isSelected = _selectedSeats.contains(seatId);

                  return GestureDetector(
                    onTap: isBooked ? null : () {
                      setState(() {
                        if (isSelected) {
                          _selectedSeats.remove(seatId);
                        } else {
                          _selectedSeats.add(seatId);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF00529B) : (isBooked ? Colors.grey[400] : Colors.grey[200]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text(seatId, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 10))),
                    ),
                  );
                },
              ),
            ),
          ),
          _buildSeatLegend(),
          _buildCheckoutSection(),
        ],
      ),
    );
  }

  Widget _buildSeatLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _legendItem(const Color(0xFF00529B), "Pilihanmu"),
          _legendItem(Colors.grey[200]!, "Tersedia"),
          _legendItem(Colors.grey[400]!, "Tidak Tersedia"),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 15, height: 15, color: color),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${_selectedSeats.length} Kursi Dipilih", style: TextStyle(color: Colors.grey[600])),
              Text("Total: Rp ${_selectedSeats.length * _ticketPrice}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            onPressed: _selectedSeats.isEmpty ? null : () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TransferConfirmationPage(
                userId: widget.userId,
                bankName: "Bank XXI",
                accountNumber: widget.movieTitle,
                amount: _selectedSeats.length * _ticketPrice,
                recipientName: "Kursi: ${_selectedSeats.join(', ')}",
                adminFee: 2000,
              )));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Pesan Tiket", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}