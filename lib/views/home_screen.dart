import 'package:flutter/material.dart';
import 'package:book_trail/widgets/home_favorite/book_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Book> books = [
      Book(title: "name book", author: "author", status: "read"),
      Book(title: "name book", author: "author", status: "want to read"),
      Book(title: "name book", author: "author", status: "reading"),
    ];

    return BookListView(books: books);
  }
}
