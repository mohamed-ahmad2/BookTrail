import 'package:book_trail/views/widgets/read_finish_want_stats.dart';
import 'package:flutter/material.dart';

class ReadFinishWantCard extends StatelessWidget {
  final int finishedCount;
  final int readingCount;
  final int toReadCount;
  const ReadFinishWantCard({super.key, required this.finishedCount, required this.readingCount, required this.toReadCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReadFinishWantStats(
          finishedCount: finishedCount,
          iconStats: Icons.check_circle_outline,
          nameStats: "Finished",
        ),

        ReadFinishWantStats(
          finishedCount: readingCount,
          iconStats: Icons.library_books,
          nameStats: "Reading",
        ),

        ReadFinishWantStats(
          finishedCount: toReadCount,
          iconStats: Icons.bookmark_border,
          nameStats: "To Read",
        ),
      ],
    );
  }
}
