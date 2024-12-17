import 'package:flutter/material.dart';
import 'MainMenuScreen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The MovieDB App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainMenuScreen(), 
    );
  }
}