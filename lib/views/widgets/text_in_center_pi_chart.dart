import 'package:flutter/material.dart';

class TextInCenterPiChart extends StatelessWidget {
  const TextInCenterPiChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "135",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
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