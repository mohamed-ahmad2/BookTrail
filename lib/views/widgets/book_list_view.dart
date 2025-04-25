import 'package:book_trail/views/widgets/custom_book_card.dart';
import 'package:flutter/material.dart';

class BookListView extends StatefulWidget {
  final List<Book> books;

  const BookListView({super.key, required this.books});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        final book = widget.books[index];
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
