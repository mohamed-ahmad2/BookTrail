import 'package:book_trail/models/book_info_data.dart';
import 'package:hive/hive.dart';

class BookOperation {
  final Box<BookInfoData> box;

  BookOperation(this.box);

  Future<void> addBook(BookInfoData book) async {
    await box.put(book.bookId!, book);
  }

  Future<void> deleteBookWithIndex(int index) async {
    await box.deleteAt(index);
  }

  Future<void> deleteBook(BookInfoData book) async {
    await box.delete(book.bookId!);
  }

  Future<void> updateBookWithIndex(int index, BookInfoData book) async {
    await box.putAt(index, book);
  }

  Future<void> updateBook(BookInfoData book) async {
    await box.put(book.bookId!, book);
  }

  List<BookInfoData> getAllBooks() {
    return box.values.toList();
  }
}
