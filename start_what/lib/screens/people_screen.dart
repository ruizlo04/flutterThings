import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeopleScreenWidget extends StatefulWidget {
  const PeopleScreenWidget({super.key});

  @override
  State<PeopleScreenWidget> createState() => _PeopleScreenWidgetState();
}

class _PeopleScreenWidgetState extends State<PeopleScreenWidget> {
  late Future<List<dynamic>> peopleResponse;

  @override
  void initState() {
    super.initState();
    peopleResponse = getPeople();
  }

  Future<List<dynamic>> getPeople() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people/'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load people');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<dynamic>>(
          future: peopleResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildPeopleGrid(snapshot.data!);
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}', style: const TextStyle(color: Colors.white)));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildPeopleGrid(List<dynamic> people) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        mainAxisExtent: 150,
      ),
      itemCount: people.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    people[index]['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}