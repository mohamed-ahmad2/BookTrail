import 'package:book_trail/views/widgets/custom_pi_chart_data.dart';
import 'package:book_trail/views/widgets/text_in_center_pi_chart.dart';
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
            CustomPiChartData(),
            TextInCenterPiChart(),
          ],
        ),
      ),
    );
  }
}
