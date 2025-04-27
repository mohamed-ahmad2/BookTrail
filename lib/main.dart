import 'package:book_trail/views/search_screen.dart';
import 'package:book_trail/views/stats_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatsScreen(totalPages: 50000, numberOfPages: 20389,),
      //home: SearchScreen(),
    );
  }
}
