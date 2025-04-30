import 'package:book_trail/models/book.dart';
import 'package:hive/hive.dart';

class BookOperation {
  final Box<Book> box;

  BookOperation(this.box);

  Future<void> addBook(Book book) async {
    await box.put(book.bookId!, book);
  }

  Future<void> deleteBookWithIndex(int index) async {
    await box.deleteAt(index);
  }

  Future<void> deleteBook(Book book) async {
    await box.delete(book.bookId!);
  }

  Future<void> updateBookWithIndex(int index, Book book) async {
    await box.putAt(index, book);
  }

  Future<void> updateBook(Book book) async {
    await box.put(book.bookId!, book);
  }

  List<Book> getAllBooks() {
    return box.values.toList();
  }
}
