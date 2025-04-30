import 'package:book_trail/views/book_info.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String bookId;
  final String author;
  final String status;
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const BookCard({
    super.key,
    required this.title,
    required this.bookId,
    required this.author,
    required this.status,
    required this.isFavorite,
    required this.onFavoriteToggle,
    this.imageUrl,
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
          MaterialPageRoute(
            builder:
                (context) => BookInfo(
                  bookId: bookId,
                  status: status,
                  isFavorite: isFavorite,
                  onFavoriteToggle: onFavoriteToggle,
                ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageUrl != null
                  ? Image.network(
                    imageUrl!,
                    width: 50,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.image, size: 50),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                  : const Icon(Icons.image, size: 50),
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
