import 'package:book_trail/models/book.dart';
import 'package:book_trail/views/widgets/home_favorite/book_list_view.dart';

import 'package:book_trail/views/widgets/stats_search/custom_search_bar_search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final books = <Book>[
    Book(title: "name book 1", author: "author 1", status: "read"),
    Book(title: "name book 2", author: "author 2", status: "want to read"),
    Book(title: "name book 3", author: "author 3", status: "reading"),
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
            SizedBox(
              height: 600,
              child: BookListView(
                books: books,
                favoriteTitles: favoriteTitles,
                toggleFavorite: toggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
