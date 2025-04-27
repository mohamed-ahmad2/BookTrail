import 'package:flutter/material.dart';

class ReadFinishWantStats extends StatelessWidget {
  final int count;
  final IconData iconStats;
  final String nameStats;
  const ReadFinishWantStats({super.key, required this.count, required this.iconStats, required this.nameStats});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(iconStats, size: 24, color: Colors.black),
              SizedBox(width: 8),
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