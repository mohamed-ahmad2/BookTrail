import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // the image of the book will be here
          height: 150,
          width: 150,
          color: Colors.grey[300],
          child: Stack(),
        ),
        SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name book',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 55),
            Text(
              'Author: ',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
          ],
        ),
      ],
    );
  }
}
