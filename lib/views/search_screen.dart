import 'package:book_trail/models/book.dart';
import 'package:book_trail/views/widgets/home_favorite/book_list_view.dart';
import 'package:book_trail/views/widgets/stats_search/book_service.dart';
import 'package:book_trail/views/widgets/stats_search/custom_search_bar_search.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Book> books = [];
  List<String> favoriteTitles = [];
  String searchQuery = '';

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch initial books with a default query
  //   _fetchBooks('books');
  // }

  // Future<void> _fetchBooks(String query) async {
  //   try {
  //     final bookInfoList = await BookService.searchBooks(query);
  //     setState(() {
  //       books = bookInfoList.map((bookInfo) => BookInfoData.fromBookInfoData(bookInfo)).toList();
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to load books: $e')),
  //     );
  //   }
  // }

  // List<Book> _filterBooks() {
  //   if (searchQuery.isEmpty) {
  //     return books;
  //   }
  //   return books.where((book) {
  //     return book.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
  //         book.author.toLowerCase().contains(searchQuery.toLowerCase());
  //   }).toList();
  // }


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
