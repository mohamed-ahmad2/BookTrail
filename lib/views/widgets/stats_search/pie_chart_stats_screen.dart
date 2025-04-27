import 'package:book_trail/views/widgets/stats_search/custom_pi_chart_data.dart';
import 'package:book_trail/views/widgets/stats_search/text_in_center_pi_chart.dart';
import 'package:flutter/material.dart';

class PieChartStatsScreen extends StatelessWidget {
  final int numberOfBooks;
  final List<Map<String, dynamic>> categories;
  const PieChartStatsScreen({super.key, required this.categories, required this.numberOfBooks});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: Stack(
          children: [
            CustomPiChartData(categories: categories),
            TextInCenterPiChart(numberOfBooks: numberOfBooks),
          ],
        ),
      ),
    );
  }
}
