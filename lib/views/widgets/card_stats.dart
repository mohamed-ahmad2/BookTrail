
import 'package:flutter/material.dart';

class CardStats extends StatelessWidget {
  final Widget card;
  const CardStats({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(244, 244, 244, 1),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      child: Column(
        children: [
          card,
        ],
      ),
    );
  }
}
