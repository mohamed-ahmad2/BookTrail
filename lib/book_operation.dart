import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:hive/hive.dart';

class BookOperation {
  Box<Book>? box;

  Future<void> initialize(String nameId) async {
    box = await Hive.openBox<Book>(kBookBox(nameId));
  }

  Future<void> addBook(Book book) async {
    if (box != null) {
      await box!.put(book.bookId!, book);
    }
  }

  Future<void> deleteBookWithIndex(int index) async {
    if (box != null) {
      await box!.deleteAt(index);
    }
  }

  Future<void> deleteBook(String? bookId) async {
    if (box != null) {
      await box!.delete(bookId!);
    }
  }

  Future<void> updateBookWithIndex(int index, Book book) async {
    if (box != null) {
      await box!.putAt(index, book);
    }
  }

  Future<void> updateBook(Book book) async {
    if (box != null) {
      await box!.put(book.bookId!, book);
    }
  }

  List<Book> getAllBooks() {
    if (box != null) {
      return box!.values.toList();
    }
    return [];
  }

  Book? getBook(String bookId) {
    if (box != null) {
      return box!.get(bookId);
    }
    return null;
  }

  Future<List<Book>> getBooksByClassification(String classification) async {
    if (box != null) {
      final filteredBooks = box!.values
          .where((book) => book.classification == classification)
          .toList();
      return filteredBooks;
    }
    return [];
  }
}
