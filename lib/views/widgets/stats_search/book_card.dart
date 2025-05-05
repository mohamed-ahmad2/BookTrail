import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/screens/book_info.dart';
import 'package:book_trail/views/widgets/stats_search/icon_button_search_card.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  final String title;
  final String bookId;
  final String author;
  final String status;
  final String? imageUrl;
  final BookOperation bookOperation;

  const BookCard({
    super.key,
    required this.title,
    required this.bookId,
    required this.author,
    required this.status,
    required this.bookOperation,
    this.imageUrl, required String classification, required String summary,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isButtonDisabled = false;

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
                (context) =>
                    BookInfo(
                      bookId: widget.bookId,
                      status: widget.status,
                      summary: "Sample summary", // Replace with actual summary
                      imageUrl: widget.imageUrl ?? '', // Provide imageUrl or default
                      isFavorite: false, // Replace with actual favorite status
                      onFavoriteToggle: () {
                        // Implement favorite toggle logic
                      },
                    ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                  ? Image.network(
                    widget.imageUrl!,
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
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.author,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButtonSearchCard(
                    title: widget.title,
                    bookId: widget.bookId,
                    status: widget.status,
                    bookOperation: widget.bookOperation,
                  ),
                  Text(widget.status, style: const TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
