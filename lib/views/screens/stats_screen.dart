import 'dart:math';
import 'package:book_trail/book_operation.dart';

import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/views/widgets/stats_search/card_stats.dart';
import 'package:book_trail/views/widgets/stats_search/color_text_pi_chart.dart';
import 'package:book_trail/views/widgets/stats_search/pie_chart_stats_screen.dart';
import 'package:book_trail/views/widgets/stats_search/progress_read_card_stats.dart';
import 'package:book_trail/views/widgets/stats_search/read_finish_want_card.dart';
import 'package:book_trail/views/widgets/stats_search/total_pages_books_read.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  final BookOperation bookOperation;
  const StatsScreen({super.key, required this.bookOperation});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late int numberOfPages = 1000;
  late int totalPages = 4000;
  List<Map<String, dynamic>> categories = [];
  int numberOfBooks = 0;

  @override
  void initState() {
    super.initState();
    _generateCategoriesFromHive();
  }

  Color generateRandomColor() {
    final Random random = Random();
    return Color(0xFF000000 + random.nextInt(0xFFFFFF));
  }

  Future<void> _generateCategoriesFromHive() async {
    await Future.delayed(Duration.zero);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;

    if (userId == null) {
      debugPrint("User ID is null. Cannot load books.");
      return;
    }

    await widget.bookOperation.initialize(userId);
    final bookList = widget.bookOperation.getAllBooks();

    final Map<String, int> classificationCounts = {};

    for (var book in bookList) {
      final classification = book.classification ?? 'Unknown';
      classificationCounts[classification] =
          (classificationCounts[classification] ?? 0) + 1;
    }

    final List<Map<String, dynamic>> generatedCategories =
        classificationCounts.entries.map((entry) {
          final color = generateRandomColor();
          return {'name': entry.key, 'value': entry.value, 'color': color};
        }).toList();

    setState(() {
      categories = generatedCategories;
      numberOfBooks = classificationCounts.values.fold(
        0,
        (sum, val) => sum + val,
      );
    });

    debugPrint("Loaded ${generatedCategories.length} categories from Hive");
    debugPrint("Categories: $generatedCategories");
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "CHART",
              style: TextStyle(
                fontSize: 14,
                color:
                    themeProvider.isDarkMode
                        ? Color(0xFFB0BEC5)
                        : Colors.grey[600],
              ),
            ),

            CardStats(
              cards: [
                PieChartStatsScreen(
                  categories: categories,
                  numberOfBooks: numberOfBooks,
                ),
                SizedBox(height: 20),
                ColorTextPiChart(categories: categories),
              ],
            ),

            Text(
              "TOTAL PAGES",
              style: TextStyle(
                fontSize: 14,
                color:
                    themeProvider.isDarkMode
                        ? Color(0xFFB0BEC5)
                        : Colors.grey[600],
              ),
            ),

            SizedBox(
              width: double.maxFinite,
              child: CardStats(
                cards: [
                  ProgressReadCardStats(
                    numberOfPages: numberOfPages,
                    totalPages: totalPages,
                  ),
                ],
              ),
            ),

            Text(
              "BOOKS BY STATUS",
              style: TextStyle(
                fontSize: 14,
                color:
                    themeProvider.isDarkMode
                        ? Color(0xFFB0BEC5)
                        : Colors.grey[600],
              ),
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
              style: TextStyle(
                fontSize: 14,
                color:
                    themeProvider.isDarkMode
                        ? Color(0xFFB0BEC5)
                        : Colors.grey[600],
              ),
            ),

            CardStats(
              cards: [
                TotalPagesBooksRead(
                  countBooks: numberOfBooks,
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
