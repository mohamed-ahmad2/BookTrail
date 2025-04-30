import 'package:hive/hive.dart';

part 'book_info_data.g.g.dart'; // Updated to match the expected generated file name

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

  BookInfoData({
    this.readingStatus,
    this.rating,
    this.startDate,
    this.endDate,
    this.notes,
  });
}