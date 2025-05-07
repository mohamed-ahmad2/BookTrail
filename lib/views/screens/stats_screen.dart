import 'dart:math';
import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/providers/notification_provider.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/views/widgets/stats_search/card_stats.dart';
import 'package:book_trail/views/widgets/stats_search/color_text_pi_chart.dart';
import 'package:book_trail/views/widgets/stats_search/pie_chart_stats_screen.dart';
import 'package:book_trail/views/widgets/stats_search/progress_read_card_stats.dart';
import 'package:book_trail/views/widgets/stats_search/read_finish_want_card.dart';
import 'package:book_trail/views/widgets/stats_search/total_pages_books_read.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  final BookOperation bookOperation;

  const StatsScreen({super.key, required this.bookOperation});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<Map<String, dynamic>> categories = [];
  int numberOfBooks = 0;
  double finishedCount = 0;
  double readingCount = 0;
  double toReadCount = 0;
  int numberOfPages = 0;
  int totalPages = 500;
  double avgRate = 0;
  Box<Book>? bookBox;
  late Stream<BoxEvent> boxStream;
  Box<int>? totalPagesBox;

  @override
  void initState() {
    super.initState();
    _setupHiveListener();
    _loadTotalPages();
  }

  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Future<void> _setupHiveListener() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;

    if (userId == null) {
      debugPrint("User ID is null. Cannot load books.");
      return;
    }

    bookBox = Hive.box<Book>(kBookBox(userId));
    boxStream = bookBox!.watch();
    _generateCategoriesFromHive();

    boxStream.listen((event) {
      _generateCategoriesFromHive();
    });
  }

  Future<void> _loadTotalPages() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;

      if (userId == null) {
        debugPrint("User ID is null. Cannot load totalPages.");
        return;
      }

      totalPagesBox = await Hive.openBox<int>('totalPagesBox_$userId');
      final savedTotalPages = totalPagesBox!.get('totalPages') ?? 500;

      if (mounted) {
        setState(() {
          totalPages = savedTotalPages;
        });
      }
    } catch (e) {
      debugPrint("Error loading totalPages: $e");
    }
  }

  Future<void> _showCelebrationMessage() async {
    final notificationProvider = Provider.of<NotificationProvider>(
      context,
      listen: false,
    );

    await notificationProvider.showNotification(
      id: Random().nextInt(1000),
      title: 'Reading Goal Achieved!',
      body: '🎉 Congratulations! You reached your reading goal! Keep going!',
      channelId: 'celebration_channel',
      channelName: 'Celebration Notifications',
    );
  }

  Future<void> _generateCategoriesFromHive() async {
    if (bookBox == null || bookBox!.isEmpty) return;

    final Map<String, int> classificationCounts = {};
    double localFinished = 0;
    double localReading = 0;
    double localToRead = 0;
    int totalRatings = 0;
    int ratedBooksCount = 0;
    int totalPagesRead = 0;

    final bookList = bookBox!.values.toList();

    for (var book in bookList) {
      final classification = book.classification ?? 'Unclassified';
      classificationCounts[classification] =
          (classificationCounts[classification] ?? 0) + 1;

      final status = book.readingStatus?.toLowerCase() ?? 'unknown';
      if (status == 'read') {
        localFinished++;
      } else if (status == 'reading') {
        localReading++;
      } else if (status == 'want to read') {
        localToRead++;
      }

      if (book.rating != null && book.rating! > 0) {
        totalRatings += book.rating!;
        ratedBooksCount++;
      }

      if (book.numberOfPages != null && book.numberOfPages! > 0) {
        totalPagesRead += book.numberOfPages!;
      }
    }

    final double avg = ratedBooksCount > 0 ? totalRatings / ratedBooksCount : 0;

    final List<Map<String, dynamic>> generatedCategories =
        classificationCounts.entries.map((entry) {
          final color = generateRandomColor();
          return {'name': entry.key, 'value': entry.value, 'color': color};
        }).toList();

    bool shouldCelebrate = totalPagesRead >= totalPages;

    if (shouldCelebrate) {
      totalPages += 200;
      await totalPagesBox?.put('totalPages', totalPages);
      await _showCelebrationMessage();
    }

    if (mounted) {
      setState(() {
        categories = generatedCategories;
        numberOfBooks = bookList.length;
        finishedCount = localFinished;
        readingCount = localReading;
        toReadCount = localToRead;
        avgRate = avg;
        numberOfPages = totalPagesRead;
      });
    }

    debugPrint(
      "Categories loaded: $categories, numberOfPages: $numberOfPages, totalPages: $totalPages",
    );
  }

  Future<void> _onRefresh() async {
    await _generateCategoriesFromHive();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "CHART",
                style: TextStyle(
                  fontSize: 14,
                  color:
                      themeProvider.isDarkMode
                          ? const Color(0xFFB0BEC5)
                          : Colors.grey[600],
                ),
              ),
              CardStats(
                cards: [
                  PieChartStatsScreen(
                    categories: categories,
                    numberOfBooks: numberOfBooks,
                  ),
                  const SizedBox(height: 20),
                  ColorTextPiChart(categories: categories),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "TOTAL PAGES",
                style: TextStyle(
                  fontSize: 14,
                  color:
                      themeProvider.isDarkMode
                          ? const Color(0xFFB0BEC5)
                          : Colors.grey[600],
                ),
              ),
              CardStats(
                cards: [
                  ProgressReadCardStats(
                    numberOfPages: numberOfPages,
                    totalPages: totalPages,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "BOOKS BY STATUS",
                style: TextStyle(
                  fontSize: 14,
                  color:
                      themeProvider.isDarkMode
                          ? const Color(0xFFB0BEC5)
                          : Colors.grey[600],
                ),
              ),
              CardStats(
                cards: [
                  ReadFinishWantCard(
                    finishedCount: finishedCount,
                    readingCount: readingCount,
                    toReadCount: toReadCount,
                    avgRate: avgRate,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "TOTAL BOOK STATS",
                style: TextStyle(
                  fontSize: 14,
                  color:
                      themeProvider.isDarkMode
                          ? const Color(0xFFB0BEC5)
                          : Colors.grey[600],
                ),
              ),
              CardStats(
                cards: [
                  TotalPagesBooksRead(
                    countBooks: numberOfBooks,
                    countPages: totalPages,
                    countRead: numberOfPages,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
