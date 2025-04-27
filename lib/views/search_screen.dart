
import 'package:book_trail/views/widgets/stats_search/book_list_view.dart';
import 'package:book_trail/views/widgets/stats_search/custom_search_bar_search.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: CustomSearchBarSearch(),
            ),
            BookListView(books: books),
          ],
        ),
      ),
    );
  }
}
//home: StatsScreen(totalPages: 50000, numberOfPages: 20389,),
//home: SearchScreen(),
