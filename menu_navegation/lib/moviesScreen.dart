import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final String apiKey = "05e17ea68b0a29c92de23f76cc1cff22";
  List<dynamic> popularMovies = [];

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey"));
    if (response.statusCode == 200) {
      setState(() {
        popularMovies = json.decode(response.body)['results'];
      });
    }
  }

  Widget _buildMovieCard(Map<String, dynamic> movie) {
    final imageUrl = movie['poster_path'];
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              "https://image.tmdb.org/t/p/w200$imageUrl",
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Puntuación: ⭐ ${movie['vote_average']}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie['overview'] ?? "Sin descripción disponible.",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🎥 Películas Populares',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: popularMovies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: popularMovies.length,
              itemBuilder: (context, index) {
                return _buildMovieCard(popularMovies[index]);
              },
            ),
    );
  }
}
