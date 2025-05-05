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
        final title = book.title ?? 'Unknown Title';
        final author = book.author ?? 'Unknown Author';
        final readingStatus = book.readingStatus ?? 'None';
        final bookId = book.bookId ?? 'unknown_${index.hashCode}';
        // ignore: unused_local_variable
        final imageUrl = book.imageUrl ?? Image.asset('assets/images/22968.jpg');// image is a string type????!
        // ignore: unused_local_variable
        final classification = book.classification ?? 'Unknown Classification';
        // ignore: unused_local_variable
        final summary = book.summary ?? 'No summary available.';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: BookCard(
            title: title,
            author: author,
            status: readingStatus,
            bookId: bookId,
            classification: book.classification,
            summary: book.summary,
            imageUrl: book.imageUrl,
            isFavorite: book.title != null ? favoriteTitles.contains(book.title) : false,
            onFavoriteToggle: () => toggleFavorite(title), clasification: '',
          ),
        );
      },
    );
  }
}