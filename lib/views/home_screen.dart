import 'package:book_trail/widgets/book_list_view.dart';
import 'package:book_trail/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_trail/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  final List<Book> books = [
    Book(title: "name book", author: "author", status: "read"),
    Book(title: "name book", author: "author", status: "want to read"),
    Book(title: "name book", author: "author", status: "reading"),
  ];

  // const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: BookListView(books: books),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }
}
