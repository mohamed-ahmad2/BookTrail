// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      bookId: fields[0] as String?,
      readingStatus: fields[1] as String?,
      rating: fields[2] as int?,
      startDate: fields[3] as DateTime?,
      endDate: fields[4] as DateTime?,
      notes: fields[5] as String?,
      title: fields[6] as String?,
      author: fields[7] as String?,
      classification: fields[8] as String?,
      summary: fields[9] as String?,
      imageUrl: fields[10] as String?,
      numberOfPages: fields[11] as int?,
      userId: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.readingStatus)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.author)
      ..writeByte(8)
      ..write(obj.classification)
      ..writeByte(9)
      ..write(obj.summary)
      ..writeByte(10)
      ..write(obj.imageUrl)
      ..writeByte(11)
      ..write(obj.numberOfPages)
      ..writeByte(12)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
