import 'package:brimo_clone/presentation/pages/movie_seat_page.dart';
import 'package:flutter/material.dart';

class MovieSchedulePage extends StatelessWidget {
  final String userId;
  final String movieTitle;
  const MovieSchedulePage({super.key, required this.userId, required this.movieTitle});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> cinemaSchedules = {
      'XXI - Transmart Buah Batu': ['12:30', '15:00', '17:30', '20:00'],
      'XXI - Miko Mall': ['13:00', '15:30', '18:00', '20:30'],
      'XXI - Ciwalk': ['12:45', '15:15', '17:45', '20:15'],
      'CGV - Cisereh': ['12:45', '15:30', '16:45', '20:30'],
      'CGV - Citra Raya': ['13:45', '14:10', '16:30', '20:45'],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(movieTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: cinemaSchedules.length,
        itemBuilder: (context, index) {
          final cinemaName = cinemaSchedules.keys.elementAt(index);
          final schedules = cinemaSchedules[cinemaName]!;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cinemaName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: schedules.map((time) {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieSeatPage(
                                userId: userId,
                                movieTitle: movieTitle,
                                cinemaName: cinemaName,
                                selectedTime: time,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.grey[200]
                        ),
                        child: Text(time),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}