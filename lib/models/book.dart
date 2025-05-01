import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book extends HiveObject {
  @HiveField(0)
  String? bookId;

  @HiveField(1)
  String? readingStatus;

  @HiveField(2)
  int? rating;

  @HiveField(3)
  DateTime? startDate;

  @HiveField(4)
  DateTime? endDate;

  @HiveField(5)
  String? notes;

  @HiveField(6)
  String? title;

  @HiveField(7)
  String? author;

  @HiveField(8)
  String? classification;

  @HiveField(9)
  String? summary;

  @HiveField(10)
  String? imageUrl;

  @HiveField(11)
  String? avgRating;

  @HiveField(12)
  String? userId;

  Book({
    this.bookId,
    this.readingStatus,
    this.rating,
    this.startDate,
    this.endDate,
    this.notes,
    this.title,
    this.author,
    this.classification,
    this.summary,
    this.imageUrl,
    this.avgRating,
    this.userId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          author == other.author;

  @override
  int get hashCode => title.hashCode ^ author.hashCode;
}