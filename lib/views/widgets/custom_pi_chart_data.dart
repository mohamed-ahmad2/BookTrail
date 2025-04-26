import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPiChartData extends StatelessWidget {
  const CustomPiChartData({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 25,
            color: const Color(0xFF59abe1),
            radius: 40,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 25,
            color: const Color(0xFFa358d7),
            radius: 40,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 25,
            color: const Color(0xFF59c4bd),
            radius: 40,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 25,
            color: const Color(0xFFf7ce46),
            radius: 40,
            showTitle: false,
          ),
        ],
        sectionsSpace: 0,
        centerSpaceRadius: 80,
      ),
    );
  }
}
