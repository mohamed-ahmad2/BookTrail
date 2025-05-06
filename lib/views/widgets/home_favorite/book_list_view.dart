import 'package:book_trail/book_operation.dart';
import 'package:flutter/material.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/views/widgets/home_favorite/custom_book_card.dart';

class BookListView extends StatelessWidget {
  final List<Book> books;
  final BookOperation bookOperation;

  const BookListView({
    super.key,
    required this.books,
    required this.bookOperation,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        final title = book.title ?? 'Unknown Title';
        final author = book.author ?? 'Unknown Author';
        final readingStatus = book.readingStatus ?? 'None';
        final bookId = book.bookId ?? 'unknown_${index.hashCode}';
        final imageUrl = book.imageUrl;
        final classification = book.classification ?? 'Unknown Classification';
        final summary = book.summary ?? 'No summary available.';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: BookCard(
            title: title,
            author: author,
            status: readingStatus,
            bookId: bookId,
            classification: classification,
            summary: summary,
            imageUrl: imageUrl,
            isFavorite: book.isFavorite ?? false,
            clasification: classification,
            bookOperation: bookOperation,
          ),
        );
      },
    );
  }
}
