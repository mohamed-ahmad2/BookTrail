import 'package:flutter/material.dart';
import 'package:book_trail/views/widgets/home_favorite/book_list_view.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  final TabController tabController;

  const HomeScreen({super.key, required this.tabController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> books = [];
  Box<Book>? _bookBox;
  bool _isBoxInitialized = false;

  List<String> favoriteTitles = [];

  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  Future<void> _openHiveBox() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.userId == null) {
        debugPrint('HomeScreen: Error: userId is null in UserProvider');
        return;
      }
      _bookBox = await Hive.openBox<Book>(kBookBox(userProvider.userId!));
      debugPrint('HomeScreen: Hive box opened for userId: ${userProvider.userId}');
      _isBoxInitialized = true;
      _loadBooks();
    } catch (e) {
      debugPrint('HomeScreen: Error opening Hive box: $e');
    }
  }

  void _loadBooks() {
    if (_isBoxInitialized && _bookBox != null) {
      setState(() {
        books = _bookBox!.values.toList();
      });
      debugPrint('HomeScreen: Books loaded: ${books.length} books');
    } else {
      debugPrint('HomeScreen: Cannot load books: Box not initialized or is null');
    }
  }

  void toggleFavorite(String title) {
    setState(() {
      if (favoriteTitles.contains(title)) {
        favoriteTitles.remove(title);
      } else {
        favoriteTitles.add(title);
      }
    });
  }

  List<Book> _filterBooks(List<Book> currentBooks) {
    if (widget.tabController.index == 0) {
      return currentBooks;
    } else if (widget.tabController.index == 1) {
      return currentBooks.where((book) => book.readingStatus == "read").toList();
    } else if (widget.tabController.index == 2) {
      return currentBooks.where((book) => book.readingStatus == "want to read").toList();
    } else if (widget.tabController.index == 3) {
      return currentBooks.where((book) => book.readingStatus == "reading").toList();
    }
    return currentBooks;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isBoxInitialized || _bookBox == null) {
      _openHiveBox();
      return const Center(child: CircularProgressIndicator());
    }
    return ValueListenableBuilder<Box<Book>>(
      valueListenable: _bookBox!.listenable(),
      builder: (context, box, _) {
        final currentBooks = box.values.toList().cast<Book>();
        debugPrint('HomeScreen: ValueListenableBuilder updated, books: ${currentBooks.length}');
        if (currentBooks.isEmpty) {
          debugPrint('HomeScreen: Books list is empty');
          return const Center(child: Text('No books available'));
        }
        return AnimatedBuilder(
          animation: widget.tabController,
          builder: (context, _) {
            return BookListView(
              books: _filterBooks(currentBooks),
              favoriteTitles: favoriteTitles,
              toggleFavorite: toggleFavorite,
            );
          },
        );
      },
    );
  }
}