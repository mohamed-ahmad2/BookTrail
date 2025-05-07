import 'dart:io';
import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/screens/book_info.dart';
import 'package:book_trail/views/widgets/stats_search/download_image_to_file.dart';
import 'package:book_trail/views/widgets/stats_search/icon_button_search_card.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  final String title;
  final String bookId;
  final String status;
  final String author;
  final String classification;
  final String summary;
  final String imageUrl;
  final BookOperation bookOperation;
  final String? webReaderLink;
  final String? viewability; // Added viewability
  final bool? embeddable;   // Changed to nullable, no default

  const BookCard({
    super.key,
    required this.title,
    required this.bookId,
    required this.author,
    required this.status,
    required this.bookOperation,
    required this.classification,
    required this.summary,
    required this.imageUrl,
    this.webReaderLink,
    this.viewability,
    this.embeddable, // Removed default value
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookInfo(
              bookOperation: widget.bookOperation,
              bookId: widget.bookId,
              status: widget.status,
              title: widget.title,
              author: widget.author,
              classification: widget.classification,
              summary: widget.summary,
              imageUrl: widget.imageUrl,
              webReaderLink: widget.webReaderLink,
              viewability: widget.viewability,
              embeddable: widget.embeddable, // Pass nullable embeddable
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<File>(
                future: downloadImageToFile(
                  widget.imageUrl,
                  'book_${widget.bookId}.jpg',
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.image, size: 50);
                  } else if (snapshot.hasData) {
                    return Image.file(
                      snapshot.data!,
                      width: 50,
                      height: 70,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return const Icon(Icons.broken_image, size: 50);
                  }
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.author,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButtonSearchCard(
                    title: widget.title,
                    bookId: widget.bookId,
                    status: widget.status,
                    author: widget.author,
                    classification: widget.classification,
                    summary: widget.summary,
                    imageUrl: widget.imageUrl,
                    bookOperation: widget.bookOperation,
                    webReaderLink: widget.webReaderLink,
                    viewability: widget.viewability,
                    embeddable: widget.embeddable, // Pass nullable embeddable
                  ),
                  Text(widget.status, style: const TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}