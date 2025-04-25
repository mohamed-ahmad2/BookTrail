import 'package:book_trail/widgets/custom_book_card.dart';
import 'package:flutter/material.dart';

class BookListView extends StatelessWidget {
  final List<Book> books;

  const BookListView({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          title: book.title,
          author: book.author,
          status: book.status,
          icon: Icons.star_border,
        );
      },
    );
  }
}

class Book {
  final String title;
  final String author;
  final String status;

  Book({required this.title, required this.author, required this.status});
}
