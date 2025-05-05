import 'dart:convert';
import 'package:book_trail/models/book.dart';
import 'package:http/http.dart' as http;

class BookService {
  static Future<List<Book>> searchBooks(String query) async {
    final url = Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$query',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items'];

      return items.map((item) {
        final volumeInfo = item['volumeInfo'];

        return Book(
          title: volumeInfo['title'],
          author:
              (volumeInfo['authors'] != null)
                  ? (volumeInfo['authors'] as List<dynamic>).join(', ')
                  : 'Unknown',
          summary: volumeInfo['description'] ?? 'No description',
          imageUrl:
              volumeInfo['imageLinks'] != null
                  ? volumeInfo['imageLinks']['thumbnail']
                  : null,
          bookId: item['id'],
          classification:
              (volumeInfo['categories'] != null)
                  ? (volumeInfo['categories'] as List<dynamic>).join(', ')
                  : 'Unclassified',
        );
      }).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
