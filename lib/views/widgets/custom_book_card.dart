import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String status;
  final IconData icon;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:9, vertical: 3),
      child: Card(
        color: Color.fromRGBO(252, 233, 254, 1),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        child: ListTile(
          leading: Icon(Icons.image),
          title: Text(title),
          subtitle: Text(author),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Icon(icon), Text(status)],
          ),
        ),
      ),
    );
  }
}
