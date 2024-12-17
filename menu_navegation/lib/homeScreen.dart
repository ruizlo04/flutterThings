import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiKey = "05e17ea68b0a29c92de23f76cc1cff22";
  List<dynamic> popularActors = [];
  List<dynamic> popularMovies = [];

  @override
  void initState() {
    super.initState();
    fetchPopularActors();
    fetchPopularMovies();
  }

  Future<void> fetchPopularActors() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/popular?api_key=$apiKey"));
    if (response.statusCode == 200) {
      setState(() {
        popularActors = json.decode(response.body)['results'];
      });
    }
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

  Widget _buildHorizontalList(List<dynamic> items) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final imageUrl = item['profile_path'] ?? item['poster_path'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        blendMode: BlendMode.darken,
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w200$imageUrl",
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          item['name'] ?? item['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🎬 CineApp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '✨ Actores Populares',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildHorizontalList(popularActors),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '🍿 Películas Populares',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildHorizontalList(popularMovies),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
