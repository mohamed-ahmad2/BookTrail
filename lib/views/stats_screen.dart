import 'package:book_trail/views/widgets/card_stats.dart';
import 'package:book_trail/views/widgets/pie_chart_stats_screen.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Design', 'value': 34, 'color': Color(0xFF59abe1)},
    {'name': 'Business & Economics', 'value': 33, 'color': Color(0xFF59c4bd)},
    {'name': 'Self-Growth', 'value': 35, 'color': Color(0xFFa358d7)},
    {'name': 'Science Fiction', 'value': 21, 'color': Color(0xFFf7ce46)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CardStats(card: PieChartStatsScreen(categories: categories, numberOfBooks: 135),),
          ),
        ],
      ),
    );
  }
}
