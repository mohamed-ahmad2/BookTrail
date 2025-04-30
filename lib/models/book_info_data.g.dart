import 'package:hive/hive.dart';

part 'book_info_data.g.g.dart';

@HiveType(typeId: 0)
class BookInfoData extends HiveObject {
  @HiveField(0)
  String? readingStatus;

  @HiveField(1)
  int? rating;

  @HiveField(2)
  DateTime? startDate;

  @HiveField(3)
  DateTime? endDate;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  String? title;

  @HiveField(6)
  String? author;

  @HiveField(7)
  String? classification;

  @HiveField(8)
  String? summary;

  @HiveField(9)
  String? imageUrl;

  BookInfoData({
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
  });
}