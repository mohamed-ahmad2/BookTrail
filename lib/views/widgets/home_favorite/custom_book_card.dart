import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/screens/book_info.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String bookId;
  final String author;
  final String status;
  final String? imageUrl;
  final String? clasification;
  final String? summary;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final BookOperation bookOperation;

  const BookCard({
    super.key,
    required this.title,
    required this.bookId,
    required this.author,
    required this.status,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.clasification,
    required this.summary,
    this.imageUrl,
    String? classification, required this.bookOperation,
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
                  bookOperation: bookOperation,
                  bookId: bookId,
                  status: status,
                  isFavorite: isFavorite,
                  onFavoriteToggle: onFavoriteToggle,
                  title: title,
                  author: author,
                  classification: clasification ?? 'Unknown Classification',
                  summary: summary ?? 'No summary available.',
                  imageUrl: imageUrl ?? '',
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
