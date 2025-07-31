import 'package:brimo_clone/presentation/pages/event_detail_page.dart';
import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  final String userId;
  const EventPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Daftar event contoh dengan tambahan deskripsi dan harga
    final List<Map<String, String>> events = [
      {
        'name': 'Konser Blackpink World Tour',
        'date': '01 November 2025',
        'location': 'Stadion GBK, Jakarta',
        'image': 'assets/images/event_konser.jpg',
        'description': 'Saksikan penampilan spektakuler dari blackpink, artis dari korea yang datang ke indonesia.',
        'price': '350000',
      },
      {
        'name': 'Pameran Teknologi IndoTech',
        'date': '20 September 2025',
        'location': 'JCC, Jakarta',
        'image': 'assets/images/event_pameran.jpg',
        'description': 'Jelajahi inovasi teknologi terkini dari berbagai perusahaan terkemuka di pameran terbesar tahun ini.',
        'price': '100000',
      },
      {
        'name': 'Marathon Kemerdekaan',
        'date': '17 Agustus 2025',
        'location': 'Monas, Jakarta',
        'image': 'assets/images/event_marathon.jpg',
        'description': 'Ikuti lari marathon untuk merayakan hari kemerdekaan Indonesia bersama ribuan pelari lainnya.',
        'price': '250000',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tiket Event"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  event['image']!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event['description']!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(
                            event['date']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(
                            event['location']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailPage(userId: userId, eventData: event),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Lihat Detail"),
                        ),
                      ),
                    ],
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