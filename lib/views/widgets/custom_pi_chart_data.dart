import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPiChartData extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  const CustomPiChartData({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections:
            categories.map((category) {
              return PieChartSectionData(
                value: category['value'].toDouble(),
                color: category['color'],
                radius: 40,
                showTitle: false,
              );
            }).toList(),
        centerSpaceRadius: 80,
        sectionsSpace: 0,
      ),
    );
  }
}
