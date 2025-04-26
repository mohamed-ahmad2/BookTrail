import 'package:flutter/material.dart';

class TextsSummery extends StatefulWidget {
  const TextsSummery({super.key});

  @override
  State<TextsSummery> createState() => _TextsSummeryState();
}

class _TextsSummeryState extends State<TextsSummery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary book',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        // Summary text field
        Text(
          "it will be a text just for display the summary of the book",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}