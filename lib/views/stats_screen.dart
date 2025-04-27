import 'package:book_trail/views/widgets/stats_search/card_stats.dart';
import 'package:book_trail/views/widgets/stats_search/color_text_pi_chart.dart';
import 'package:book_trail/views/widgets/stats_search/pie_chart_stats_screen.dart';
import 'package:book_trail/views/widgets/stats_search/progress_read_card_stats.dart';
import 'package:book_trail/views/widgets/stats_search/read_finish_want_card.dart';
import 'package:book_trail/views/widgets/stats_search/total_pages_books_read.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({
    super.key,
    required this.totalPages,
    required this.numberOfPages,
  });

  final int numberOfPages;
  final int totalPages;

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Fantasy', 'value': 40, 'color': Color(0xFF59abe1)},
    {'name': 'Horror', 'value': 28, 'color': Color(0xFF59c4bd)},
    {'name': 'Adventures', 'value': 32, 'color': Color(0xFFa358d7)},
    {'name': 'Mystery', 'value': 23, 'color': Color(0xFFf7ce46)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "CHART",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            CardStats(
              cards: [
                PieChartStatsScreen(categories: categories, numberOfBooks: 135),
                SizedBox(height: 20),
                ColorTextPiChart(categories: categories),
              ],
            ),

            Text(
              "TOTAL PAGES",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(
              width: double.maxFinite,
              child: CardStats(
                cards: [
                  ProgressReadCardStats(
                    numberOfPages: widget.numberOfPages,
                    totalPages: widget.totalPages,
                  ),
                ],
              ),
            ),

            Text(
              "BOOKS BY STATUS",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            CardStats(
              cards: [
                ReadFinishWantCard(
                  finishedCount: 45,
                  readingCount: 30,
                  toReadCount: 100,
                  avgRate: 4,
                ),
              ],
            ),

            Text(
              "BOOKS BY STATUS",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            CardStats(
              cards: [
                TotalPagesBooksRead(
                  countBooks: 135,
                  countPages: 50000,
                  countRead: 20389,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
