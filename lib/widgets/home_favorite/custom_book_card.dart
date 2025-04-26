import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String status;
  final IconData icon;

  const BookCard({
    required this.title,
    required this.author,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.image),
        title: Text(title),
        subtitle: Text(author),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), Text(status)],
        ),
      ),
    );
  }
}
