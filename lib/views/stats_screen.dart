import 'package:book_trail/views/widgets/pie_chart_stats_screen.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          PieChartStatsScreen(),
        ],
      )
    );
  }
}
