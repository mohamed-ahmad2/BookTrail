class Book {
  final String title;
  final String author;
  final String status;

  Book({required this.title, required this.author, required this.status});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          author == other.author;

  @override
  int get hashCode => title.hashCode ^ author.hashCode;

  get classification => null;

  get summary => null;

  get imageUrl => null;
}
