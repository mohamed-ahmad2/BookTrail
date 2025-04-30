// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_info_data.g.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookInfoDataAdapter extends TypeAdapter<BookInfoData> {
  @override
  final int typeId = 0;

  @override
  BookInfoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookInfoData(
      readingStatus: fields[0] as String?,
      rating: fields[1] as int?,
      startDate: fields[2] as DateTime?,
      endDate: fields[3] as DateTime?,
      notes: fields[4] as String?,
      title: fields[5] as String?,
      author: fields[6] as String?,
      classification: fields[7] as String?,
      summary: fields[8] as String?,
      imageUrl: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookInfoData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.readingStatus)
      ..writeByte(1)
      ..write(obj.rating)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.author)
      ..writeByte(7)
      ..write(obj.classification)
      ..writeByte(8)
      ..write(obj.summary)
      ..writeByte(9)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookInfoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
