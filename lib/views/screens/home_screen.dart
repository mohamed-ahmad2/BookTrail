import 'package:flutter/material.dart';
import 'package:book_trail/views/widgets/home_favorite/book_list_view.dart';
import 'package:book_trail/models/book.dart';

class HomeScreen extends StatefulWidget {
  final TabController tabController;

  const HomeScreen({super.key, required this.tabController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> books = [
    Book(title: "Book 1", author: "Author A", readingStatus: "read"),
    Book(title: "Book 2", author: "Author B", readingStatus: "want to read"),
    Book(title: "Book 3", author: "Author C", readingStatus: "reading"),
    Book(title: "Book 4", author: "Author D", readingStatus: "read"),
  ];

  List<String> favoriteTitles = [];

  void toggleFavorite(String title) {
    setState(() {
      if (favoriteTitles.contains(title)) {
        favoriteTitles.remove(title);
      } else {
        favoriteTitles.add(title);
      }
    });
  }

  List<Book> _filterBooks() {
    if (widget.tabController.index == 0) {
      return books;
    } else if (widget.tabController.index == 1) {
      return books.where((book) => book.readingStatus == "read").toList();
    } else if (widget.tabController.index == 2) {
      return books.where((book) => book.readingStatus == "want to read").toList();
    } else if (widget.tabController.index == 3) {
      return books.where((book) => book.readingStatus == "reading").toList();
    }
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.tabController,
      builder: (context, _) {
        return BookListView(
          books: _filterBooks(),
          favoriteTitles: favoriteTitles,
          toggleFavorite: toggleFavorite,
        );
      },
    );
  }
}
