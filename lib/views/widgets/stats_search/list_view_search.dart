import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/widgets/stats_search/book_card.dart';
import 'package:flutter/material.dart';
import 'package:book_trail/models/book.dart';

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
        final imageUrl = book.imageUrl ?? ''; // Default to an empty string if null
        final classification = book.classification ?? 'Unknown Classification';
        final summary = book.summary ?? 'No summary available.';
        final webReaderLink = book.webReaderLink; // Pass webReaderLink
        final viewability = book.viewability; // Pass viewability
        final embeddable = book.embeddable; // Pass embeddable (bool?)

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: BookCard(
            title: title,
            author: author,
            status: readingStatus,
            bookId: bookId,
            imageUrl: imageUrl,
            classification: classification,
            summary: summary,
            bookOperation: bookOperation,
            webReaderLink: webReaderLink,
            viewability: viewability,
            embeddable: embeddable, // Pass nullable embeddable
          ),
        );
      },
    );
  }
}