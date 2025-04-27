import 'package:flutter/material.dart';

class TextInCenterPiChart extends StatelessWidget {
  final int numberOfBooks;
  const TextInCenterPiChart({super.key, required this.numberOfBooks});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            numberOfBooks.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60,
              color: Colors.black
              ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.book,
                size: 25,
                color: const Color.fromARGB(255, 78, 78, 78),
              ),
              Text(
                "Books",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: const Color.fromARGB(255, 78, 78, 78),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
