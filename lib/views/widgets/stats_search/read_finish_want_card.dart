import 'package:book_trail/views/widgets/stats_search/read_finish_want_stats.dart';
import 'package:flutter/material.dart';

class ReadFinishWantCard extends StatelessWidget {
  final double finishedCount;
  final double readingCount;
  final double toReadCount;
  final double avgRate;
  const ReadFinishWantCard({super.key, required this.finishedCount, required this.readingCount, required this.toReadCount, required this.avgRate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReadFinishWantStats(
          count: finishedCount,
          iconStats: Icons.check_circle_outline,
          nameStats: "Finished",
        ),

        ReadFinishWantStats(
          count: readingCount,
          iconStats: Icons.library_books,
          nameStats: "Reading",
        ),

        ReadFinishWantStats(
          count: toReadCount,
          iconStats: Icons.bookmark_border,
          nameStats: "To Read",
        ),

        ReadFinishWantStats(
          count: avgRate,
          iconStats: Icons.star_border_outlined,
          nameStats: "Avg Star",
        ),
      ],
    );
  }
}
