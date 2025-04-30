import 'package:book_trail/views/book_info.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String status;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final String classification;
  final String summary;
  final String imageUrl;


  const BookCard({super.key, 
    required this.title,
    required this.author,
    required this.status,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.classification,
    required this.summary,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookInfo(bookId: '', title: title, author: author, status: status, isFavorite: isFavorite, onFavoriteToggle: onFavoriteToggle, classification: classification, summary: summary, imageUrl: imageUrl,)),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.image, size: 50),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(author, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : null,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                  Text(status, style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
