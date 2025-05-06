import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/views/widgets/home_favorite/book_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  final TabController tabController;
  final BookOperation bookOperation;

  const FavoritesScreen({
    super.key,
    required this.tabController,
    required this.bookOperation,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Box<Book>? _bookBox;
  bool _isBoxInitialized = false;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  Future _openHiveBox() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;

      if (userId == null) {
        debugPrint('FavoritesScreen: Error - userId is null.');
        return;
      }

      _bookBox = await Hive.openBox<Book>(kBookBox(userId));
      await widget.bookOperation.initialize(userId);

      setState(() {
        _isBoxInitialized = true;
      });

      debugPrint('FavoritesScreen: Hive box opened for userId: $userId');
    } catch (e) {
      debugPrint('FavoritesScreen: Error opening Hive box: $e');
    }
  }

  List<Book> _filterBooks(List<Book> favoriteBooks) {
    switch (widget.tabController.index) {
      case 1:
        return favoriteBooks
            .where((book) => book.readingStatus?.toLowerCase() == "read")
            .toList();
      case 2:
        return favoriteBooks
            .where(
              (book) => book.readingStatus?.toLowerCase() == "want to read",
            )
            .toList();
      case 3:
        return favoriteBooks
            .where((book) => book.readingStatus?.toLowerCase() == "reading")
            .toList();
      default:
        return favoriteBooks;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isBoxInitialized || _bookBox == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ValueListenableBuilder<Box<Book>>(
      valueListenable: _bookBox!.listenable(),
      builder: (context, box, _) {
        final favoriteBooks = widget.bookOperation.getFavoriteBooks();
        debugPrint(
          'FavoritesScreen: Rebuilt with ${favoriteBooks.length} favorite books',
        );

        if (favoriteBooks.isEmpty) {
          return const Center(child: Text('No favorite books available'));
        }

        return AnimatedBuilder(
          animation: widget.tabController,
          builder: (context, _) {
            return BookListView(
              books: _filterBooks(favoriteBooks),
              bookOperation: widget.bookOperation,
            );
          },
        );
      },
    );
  }
}
