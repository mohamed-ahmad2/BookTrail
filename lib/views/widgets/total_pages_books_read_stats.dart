import 'package:flutter/material.dart';

class TotalPagesBooksReadStats extends StatelessWidget {
  final int count;
  final String nameStats;
  const TotalPagesBooksReadStats({super.key, required this.count, required this.nameStats});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  nameStats,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
  }
}