// ignore_for_file: file_names

import 'package:book_trail/book_operation.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconButtonSearchCard extends StatefulWidget {
  final String title;
  final String bookId;
  final String status;
  final String author;
  final String classification;
  final String summary;
  final String imageUrl;
  final BookOperation bookOperation;

  const IconButtonSearchCard({
    super.key,
    required this.title,
    required this.bookId,
    required this.status,
    required this.author,
    required this.classification,
    required this.summary,
    required this.imageUrl,
    required this.bookOperation,
  });

  @override
  // ignore: library_private_types_in_public_api
  _IconButtonSearchCardState createState() => _IconButtonSearchCardState();
}

class _IconButtonSearchCardState extends State<IconButtonSearchCard> {
  bool isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _checkIfBookExists();
  }

  Future<void> _checkIfBookExists() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await widget.bookOperation.initialize(userProvider.userId!);

    final existingBook = widget.bookOperation.getBook(widget.bookId);

    if (existingBook != null) {
      setState(() {
        isButtonDisabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      icon: Icon(
        Icons.add,
        color:
            themeProvider.isDarkMode
                ? (isButtonDisabled
                    ? const Color.fromARGB(255, 84, 84, 84)
                    : const Color.fromARGB(255, 255, 255, 255))
                : (isButtonDisabled
                    ? Colors.grey
                    : const Color.fromARGB(255, 0, 0, 0)),
      ),
      onPressed:
          isButtonDisabled
              ? null
              : () async {
                final userProvider = Provider.of<UserProvider>(
                  context,
                  listen: false,
                );

                await widget.bookOperation.initialize(userProvider.userId!);

                final existingBook = widget.bookOperation.getBook(
                  widget.bookId,
                );

                if (existingBook != null) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('This book is already added!'),
                      ),
                    );
                  }
                  return;
                }

                Book book = Book(
                  bookId: widget.bookId,
                  title: widget.title,
                  readingStatus: widget.status,
                  author: widget.author,
                  classification: widget.classification,
                  summary: widget.summary,
                  imageUrl: widget.imageUrl,
                  userId: userProvider.userId,
                );

                await widget.bookOperation.addBook(book);

                setState(() {
                  isButtonDisabled = true;
                });

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Book added successfully!')),
                  );
                }
              },
    );
  }
}
