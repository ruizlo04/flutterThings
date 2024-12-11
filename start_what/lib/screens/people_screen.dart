import 'package:flutter/material.dart';
import 'package:start_what/people_response/people_response.dart';
import 'package:http/http.dart' as http;

class PeopleScreenWidget extends StatefulWidget {
  const PeopleScreenWidget({super.key});

  @override
  State<PeopleScreenWidget> createState() => _PeopleScreenWidgetState();
}

class _PeopleScreenWidgetState extends State<PeopleScreenWidget> {
  late Future<PeopleResponse> peopleResponse;

  @override
  void initState() {
   super.initState();
   peopleResponse = getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
    body: FutureBuilder<PeopleResponse>(
    future: peopleResponse,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return _buildPeopleList(snapshot.data!);
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();
    },
    ),
  );
  }

  Future<PeopleResponse> getPeople() async {
  final response = await http
      .get(Uri.parse('https://swapi.dev/api/people'));

  if (response.statusCode == 200) {
    return PeopleResponse.fromJson((response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

  Widget _buildPeopleList(PeopleResponse peopleResponse) {
    return ListView.builder(
      itemCount: peopleResponse.results!.length, 
      itemBuilder: (context, index) {
        return Text(peopleResponse.results![index].name!);
      }
    ); 
  }
}