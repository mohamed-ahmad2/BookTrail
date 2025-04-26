import 'package:flutter/material.dart';

class ProgressReadCardStats extends StatelessWidget {
  final int numberOfPages;
  final int totalPages;
  const ProgressReadCardStats({super.key, required this.numberOfPages, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    double progress = numberOfPages / totalPages;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            numberOfPages.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),

          SizedBox(height: 8),

          Text(
            'Read pages of ${totalPages.toString()} total pages from all books',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),

          SizedBox(height: 8),

          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
