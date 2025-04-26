
import 'package:flutter/material.dart';

class CardStats extends StatelessWidget {
  final List<Widget> cards;
  const CardStats({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical:  5),
      child: Card(
        elevation: 4,
        color: Color.fromRGBO(244, 244, 244, 1),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        child: Column(
          children: cards,
        ),
      ),
    );
  }
}
