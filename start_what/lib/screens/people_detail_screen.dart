import 'package:flutter/material.dart';
import 'package:start_what/people_response/result.dart';

class PeopleDetailScreen extends StatefulWidget {
  final People peopleItem;
  const PeopleDetailScreen({super.key, required this.peopleItem});

  @override
  State<PeopleDetailScreen> createState() => _PeopleDetailScreenState();
}

class _PeopleDetailScreenState extends State<PeopleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(widget.peopleItem.name ?? 'Details'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'hero-${widget.peopleItem.name}',
                  child: Image.network(
                    'https://starwars-visualguide.com/assets/img/characters/${widget.peopleItem.id}.jpg',
                    width: 200,
                    height: 200,
                ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Text(
                    widget.peopleItem.name ?? 'Unknown Name',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(
                  height: 50.0,
                  thickness: 1.0,
                  color: Colors.white,
                ),
                DetailBox(title: 'Tamaño', value: widget.peopleItem.height),
                DetailBox(title: 'Masa', value: widget.peopleItem.mass),
                DetailBox(title: 'Color Pelo', value: widget.peopleItem.hairColor),
                DetailBox(title: 'Color Piel', value: widget.peopleItem.skinColor),
                DetailBox(title: 'Color Ojos', value: widget.peopleItem.eyeColor),
                DetailBox(title: 'Año nacimiento', value: widget.peopleItem.birthYear),
                DetailBox(title: 'Género', value: widget.peopleItem.gender),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailBox extends StatelessWidget {
  final String title;
  final String? value;

  const DetailBox({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value ?? 'Unknown',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
