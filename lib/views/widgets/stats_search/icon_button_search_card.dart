// ignore_for_file: file_names

import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconButtonSearchCard extends StatefulWidget {
  final String title;
  final String bookId;
  final String status;
  final BookOperation bookOperation;

  const IconButtonSearchCard({
    super.key,
    required this.title,
    required this.bookId,
    required this.status,
    required this.bookOperation,
  });

  @override
  // ignore: library_private_types_in_public_api
  _IconButtonSearchCardState createState() => _IconButtonSearchCardState();
}

class _IconButtonSearchCardState extends State<IconButtonSearchCard> {
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return IconButton(
      icon: Icon(
        Icons.add,
        color: isButtonDisabled ? Colors.grey : const Color.fromARGB(255, 0, 0, 0),
      ),
      onPressed: isButtonDisabled
          ? null
          : () async {
              await widget.bookOperation.initialize(
                kBookBox(userProvider.userId),
              );

              final existingBook = widget.bookOperation.getBook(widget.bookId);

              if (existingBook != null) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This book is already added!')),
                  );
                }
                return;
              }

              Book book = Book(
                bookId: widget.bookId,
                title: widget.title,
                readingStatus: widget.status,
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

