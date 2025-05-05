import 'package:book_trail/book_operation.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/views/widgets/stats_search/book_service.dart';
import 'package:book_trail/views/widgets/stats_search/custom_search_bar_search.dart';
import 'package:book_trail/views/widgets/stats_search/download_image_to_file.dart';
import 'package:book_trail/views/widgets/stats_search/list_view_search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final BookOperation bookOperation;
  const SearchScreen({super.key, required this.bookOperation});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Book> books = [];
  String searchQuery = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks('books');
  }

  Future<void> _fetchBooks(String query) async {
    setState(() {
      isLoading = true;
    });

    final bookStorage = BookOperation();
    await bookStorage.initialize('searchBox');

    try {
      final bookList = await BookService.searchBooks(query);

      if (!mounted) return;

      for (final book in bookList) {
        final existingBook = bookStorage.getBook(book.bookId!);

        if (existingBook == null) {
          if (book.imageUrl != null && book.imageUrl!.isNotEmpty) {
            await downloadImageToFile(
              book.imageUrl!,
              'book_${book.bookId}.jpg',
            );
          }

          await bookStorage.addBook(book);
        }
      }

      final hiveBooks = bookStorage.getAllBooks();

      setState(() {
        books = hiveBooks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('failed $e')));
      }
    }
  }

  List<Book> _filterBooks() {
    if (searchQuery.isEmpty) {
      return books;
    }
    return books.where((book) {
      final title = book.title?.toLowerCase() ?? '';
      final author = book.author?.toLowerCase() ?? '';
      return title.contains(searchQuery.toLowerCase()) ||
          author.contains(searchQuery.toLowerCase());
    }).toList();
  }

  Future<void> _handleRefresh() async {
    await _fetchBooks(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: CustomSearchBarSearch(
                  onSearch: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                    if (query.isNotEmpty) {
                      _fetchBooks(query);
                    }
                  },
                ),
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: MediaQuery.of(context).size.height - 150,
                      child: BookListView(
                        books: _filterBooks(),
                        bookOperation: widget.bookOperation,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
