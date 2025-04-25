import 'package:book_trail/views/widgets/book_list_view.dart';
import 'package:book_trail/views/widgets/custom_app_bar_search.dart';
import 'package:book_trail/views/widgets/custom_navigation_bar.dart';
import 'package:book_trail/views/widgets/custom_search_bar_search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Book> books = [
    Book(title: "name book", author: "author", status: "read"),
    Book(title: "name book", author: "author", status: "want to read"),
    Book(title: "name book", author: "author", status: "reading"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSearch(),
      body: Column(
        children: [
          CustomSearchBarSearch(),
          Expanded(child: BookListView(books: books)),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }
}
