import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartStatsScreen extends StatelessWidget {
  const PieChartStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: Stack(
          children: [
            PieChart(
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
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "135",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.book,
                        size: 25,
                        color: const Color.fromARGB(255, 78, 78, 78),
                      ),
                      Text(
                        "Books",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: const Color.fromARGB(255, 78, 78, 78),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
