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
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: books.length,
  //     itemBuilder: (context, index) {
  //       final book = books[index];
  //       return BookCard(
  //         title: book.title,
  //         author: book.author,
  //         status: book.status,
  //         isFavorite: favoriteTitles.contains(book.title),
  //         onFavoriteToggle: () => toggleFavorite(book.title),
  //       );
  //     },
  //   );
  // }
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: BookCard(
            title: book.title,
            author: book.author,
            status: book.status,
            isFavorite: favoriteTitles.contains(book.title),
            onFavoriteToggle: () => toggleFavorite(book.title),
            classification: book.classification,
            summary: book.summary,
            imageUrl: book.imageUrl,
          ),
        );
      },
    );
  }
}
