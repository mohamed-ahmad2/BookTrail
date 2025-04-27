import 'package:book_trail/views/widgets/total_pages_books_read_stats.dart';
import 'package:flutter/material.dart';

class TotalPagesBooksRead extends StatelessWidget {
  final int countBooks;
  final int countPages;
  final int countRead;

  const TotalPagesBooksRead({super.key, required this.countBooks, required this.countPages, required this.countRead});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TotalPagesBooksReadStats(nameStats: "Total Books", count: countBooks),
        TotalPagesBooksReadStats(nameStats: "Total Pages", count: countPages),
        TotalPagesBooksReadStats(nameStats: "Total Read Pages", count: countRead),
      ],
    );
  }
}
