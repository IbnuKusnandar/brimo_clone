import 'package:brimo_clone/presentation/pages/movie_schedule_page.dart';
import 'package:flutter/material.dart';

class TiketCgvPage extends StatelessWidget {
  final String userId;
  const TiketCgvPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Daftar film contoh untuk CGV
    final List<Map<String, String>> movies = [
      {
        'title': 'Godzilla x Kong: The New Empire',
        'poster': 'assets/images/poster_godzilla.jpg', // Pastikan gambar ini ada
        'genre': 'Action, Sci-Fi, Thriller',
        'duration': '115 min',
      },
      {
        'title': 'Dune: Part Two',
        'poster': 'assets/images/poster_dune.jpg', // Pastikan gambar ini ada
        'genre': 'Action, Adventure, Drama',
        'duration': '166 min',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Now Playing di CGV"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieSchedulePage(userId: userId, movieTitle: movie['title']!),
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    movie['poster']!,
                    width: 120,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie['genre']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 16, color: Colors.grey[700]),
                              const SizedBox(width: 4),
                              Text(
                                movie['duration']!,
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
                                    builder: (context) =>
                                        MovieSchedulePage(userId: userId, movieTitle: movie['title']!),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text("Beli Tiket"),
                            ),
                          ),
                        ],
                      ),
                    ),
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