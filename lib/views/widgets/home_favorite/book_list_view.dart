import 'package:flutter/material.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/views/widgets/home_favorite/custom_book_card.dart';

class BookListView extends StatelessWidget {
  final List<Book> books;
  final List<String> favoriteTitles;
  final Function(String) toggleFavorite;

  const BookListView({
    super.key,
    required this.books,
    required this.favoriteTitles,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        // Use null checks to provide fallback values
        final title = book.title ?? 'Unknown Title';
        final author = book.author ?? 'Unknown Author';
        final readingStatus = book.readingStatus ?? 'None';
        final bookId = book.bookId ?? 'unknown_${index.hashCode}';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: BookCard(
            imageUrl: book.imageUrl,
            title: title,
            author: author,
            status: readingStatus,
            bookId: bookId,
            isFavorite:
                book.title != null
                    ? favoriteTitles.contains(book.title)
                    : false,
            onFavoriteToggle: () => toggleFavorite(title),
          ),
        );
      },
    );
  }
}
