import 'dart:convert';
import 'package:book_trail/models/book.dart';
import 'package:http/http.dart' as http;

class BookService {
  static Future<List<Book>> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      throw Exception('Search query cannot be empty');
    }

    final url = Uri.parse(
      "https://www.googleapis.com/books/v1/volumes?q=${Uri.encodeQueryComponent(query)}",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List items = data['items'] ?? [];

        return items.map((item) {
          final volumeInfo = item['volumeInfo'] ?? {};
          final accessInfo = item['accessInfo'] ?? {};

          return Book(
            title: volumeInfo['title'] ?? 'Untitled',
            author: (volumeInfo['authors'] != null)
                ? (volumeInfo['authors'] as List<dynamic>).join(', ')
                : 'Unknown',
            summary: volumeInfo['description'] ?? 'No description available',
            imageUrl: volumeInfo['imageLinks'] != null
                ? volumeInfo['imageLinks']['thumbnail']
                : null,
            bookId: item['id'] ?? '',
            classification: (volumeInfo['categories'] != null)
                ? (volumeInfo['categories'] as List<dynamic>).join(', ')
                : 'Unclassified',
            webReaderLink: accessInfo['webReaderLink'],
            viewability: accessInfo['viewability'] ?? 'NONE',
            embeddable: accessInfo['embeddable'] ?? false,
          );
        }).toList();
      } else {
        throw Exception('Failed to load books: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }
}