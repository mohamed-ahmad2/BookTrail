import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookInfo extends StatefulWidget {
  final String bookId;
  final String title;
  final String author;
  final String classification;
  final String summary;
  final String imageUrl;
  final BookOperation bookOperation;

  const BookInfo({
    super.key,
    required this.bookId,
    this.title = 'Name book',
    this.author = 'The Great Author',
    this.classification = 'Classification',
    this.summary = 'No summary available.',
    this.imageUrl = '',
    required String status,
    required this.bookOperation,
  });

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _numberOfPagesController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _readingStatus;
  int _rating = 0;
  Box<Book>? _bookInfoBox;
  bool _isBoxInitialized = false;

  late String _title;
  late String _author;
  late String _classification;
  late String _summary;
  late String _imageUrl;
  int? _numberOfPages;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _author = widget.author;
    _classification = widget.classification;
    _summary = widget.summary;
    _imageUrl = widget.imageUrl;

    _openHiveBox().then((_) {
      if (mounted) _loadBookInfo();
    });
  }

  Future<void> _openHiveBox() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.userId == null) {
        debugPrint('Error: userId is null in UserProvider');
        return;
      }
      _bookInfoBox = await Hive.openBox<Book>(kBookBox(userProvider.userId!));
      debugPrint(
        'BookInfo: Hive box opened for userId: ${userProvider.userId}',
      );
      _isBoxInitialized = true;
    } catch (e) {
      debugPrint('BookInfo: Error opening Hive box: $e');
    }
  }

  Future<void> _loadBookInfo() async {
    if (!_isBoxInitialized) await _openHiveBox();
    if (_bookInfoBox == null || !mounted) {
      debugPrint(
        'BookInfo: Cannot load book info: Box not initialized or widget not mounted',
      );
      return;
    }
    final bookData = _bookInfoBox!.get(widget.bookId);
    if (bookData != null && mounted) {
      setState(() {
        _readingStatus = bookData.readingStatus;
        _rating = bookData.rating ?? 0;
        _startDate = bookData.startDate;
        _endDate = bookData.endDate;
        _statusController.text = bookData.notes ?? '';
        _title = bookData.title ?? widget.title;
        _author = bookData.author ?? widget.author;
        _classification = bookData.classification ?? widget.classification;
        _summary = bookData.summary ?? widget.summary;
        _imageUrl = bookData.imageUrl ?? widget.imageUrl;
        _numberOfPages = bookData.numberOfPages;
        _numberOfPagesController.text = _numberOfPages?.toString() ?? '';
      });
      debugPrint('BookInfo: Loaded book with ID: ${widget.bookId}');
    } else {
      debugPrint('BookInfo: No book found with ID: ${widget.bookId}');
    }
  }

  Future<void> _saveBookInfo() async {
    if (_readingStatus == null &&
        _rating == 0 &&
        _startDate == null &&
        _endDate == null &&
        _statusController.text.isEmpty &&
        _numberOfPagesController.text.isEmpty) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('No Changes Made'),
              content: const Text(
                'You must change at least one field (Reading Status, Rating, Start Date, End Date, Notes, or Number of Pages) to save the data.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    if (_bookInfoBox == null) {
      debugPrint('BookInfo: Cannot save book info: Hive box not initialized');
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    /// Create the book instance
    final bookData = Book(
      bookId: widget.bookId,
      readingStatus: _readingStatus,
      rating: _rating,
      startDate: _startDate,
      endDate: _endDate,
      notes: _statusController.text,
      title: _title,
      author: _author,
      classification: _classification,
      summary: _summary,
      imageUrl: _imageUrl,
      numberOfPages: int.tryParse(_numberOfPagesController.text),
      userId: userProvider.userId,
      isFavorite: _bookInfoBox!.get(widget.bookId)!.isFavorite,
    );

    /// Save to local screen box
    await _bookInfoBox!.put(widget.bookId, bookData);

    /// Create a separate copy for the user's box to avoid reusing the same HiveObject
    final userBookData = Book(
      bookId: widget.bookId,
      readingStatus: _readingStatus,
      rating: _rating,
      startDate: _startDate,
      endDate: _endDate,
      notes: _statusController.text,
      title: _title,
      author: _author,
      classification: _classification,
      summary: _summary,
      imageUrl: _imageUrl,
      numberOfPages: int.tryParse(_numberOfPagesController.text),
      userId: userProvider.userId,
      isFavorite: _bookInfoBox!.get(widget.bookId)!.isFavorite,
    );

    /// Save to user's personal Hive box
    await widget.bookOperation.initialize((userProvider.userId!));
    await widget.bookOperation.updateBook(userBookData);

    if (mounted) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text(
                'The book information has been updated successfully.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }

    debugPrint('BookInfo: Updated book with ID: ${widget.bookId}');
  }

  Future<void> _deleteBook() async {
    if (_bookInfoBox == null) {
      debugPrint('BookInfo: Cannot delete book: Hive box not initialized');
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final bookId = widget.bookId;

    debugPrint('BookInfo: Attempting to delete book with ID: $bookId');

    // Check if the book exists in bookInfo box
    final bookInInfoBox = _bookInfoBox!.containsKey(bookId);

    // Check if the book exists in the user's box
    await widget.bookOperation.initialize(userProvider.userId!);
    final bookInUserBox = widget.bookOperation.getBook(bookId) != null;

    // If not found in either, show a message
    if (!bookInInfoBox && !bookInUserBox) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Book not found. Nothing to delete.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      debugPrint('BookInfo: Book with ID $bookId not found in any box.');
      return;
    }

    // Delete from book info box if exists
    if (bookInInfoBox) {
      await _bookInfoBox!.delete(bookId);
      debugPrint('BookInfo: Deleted from _bookInfoBox');
    }

    // Delete from user box if exists
    if (bookInUserBox) {
      await widget.bookOperation.deleteBook(bookId);
      debugPrint('BookInfo: Deleted from user box');
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Book deleted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }

    debugPrint('BookInfo: Finished deleting book with ID: $bookId');
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Information'),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _deleteBook),
          IconButton(icon: const Icon(Icons.save), onPressed: _saveBookInfo),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Card(
                elevation: 4.0,
                color:
                    themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color:
                        themeProvider.isDarkMode
                            ? Colors.grey[200]!
                            : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Card(
                        elevation: 4.0,
                        color:
                            themeProvider.isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color:
                                themeProvider.isDarkMode
                                    ? Colors.grey[200]!
                                    : Colors.grey[800]!,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FadeInImage(
                              image:
                                  _imageUrl.isNotEmpty
                                      ? NetworkImage(_imageUrl)
                                      : const AssetImage(
                                            'assets/images/22968.jpg',
                                          )
                                          as ImageProvider,
                              placeholder: const AssetImage(
                                'assets/images/22968.jpg',
                              ),
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/22968.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _title,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'Author: $_author',
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    themeProvider.isDarkMode
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Classification: $_classification',
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    themeProvider.isDarkMode
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              // ignore: sized_box_for_whitespace
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 4.0,
                  color:
                      themeProvider.isDarkMode
                          ? Colors.grey[800]
                          : Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color:
                          themeProvider.isDarkMode
                              ? Colors.grey[200]!
                              : Colors.grey[800]!,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Summary book',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _summary,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                themeProvider.isDarkMode
                                    ? Colors.grey[200]
                                    : Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color:
                    themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color:
                        themeProvider.isDarkMode
                            ? Colors.grey[200]!
                            : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Rating',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                themeProvider.isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 30.0,
                            ),
                            onPressed: () {
                              setState(() => _rating = index + 1);
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 8.0),
                      Center(
                        child: Text(
                          'Selected Rating: $_rating/5',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color:
                    themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color:
                        themeProvider.isDarkMode
                            ? Colors.grey[200]!
                            : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Reading Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                themeProvider.isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.done, color: Colors.grey[650]),
                          const SizedBox(width: 8.0),
                          const Expanded(child: Text('read')),
                          Radio<String>(
                            value: 'read',
                            groupValue: _readingStatus,
                            onChanged:
                                (value) =>
                                    setState(() => _readingStatus = value!),
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                              (states) =>
                                  states.contains(WidgetState.selected)
                                      ? (themeProvider.isDarkMode
                                          ? Colors.blue
                                          : Colors.black)
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.book, color: Colors.grey[650]),
                          const SizedBox(width: 8.0),
                          const Expanded(child: Text('reading')),
                          Radio<String>(
                            value: 'reading',
                            groupValue: _readingStatus,
                            onChanged:
                                (value) =>
                                    setState(() => _readingStatus = value!),
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                              (states) =>
                                  states.contains(WidgetState.selected)
                                      ? (themeProvider.isDarkMode
                                          ? Colors.blue
                                          : Colors.black)
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.bookmark_border, color: Colors.grey[650]),
                          const SizedBox(width: 8.0),
                          const Expanded(child: Text('want to read')),
                          Radio<String>(
                            value: 'want to read',
                            groupValue: _readingStatus,
                            onChanged:
                                (value) =>
                                    setState(() => _readingStatus = value!),
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                              (states) =>
                                  states.contains(WidgetState.selected)
                                      ? (themeProvider.isDarkMode
                                          ? Colors.blue
                                          : Colors.black)
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color:
                    themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color:
                        themeProvider.isDarkMode
                            ? Colors.grey[200]!
                            : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _startDate == null
                                    ? 'mm/dd/yyyy'
                                    : DateFormat(
                                      'MM/dd/yyyy',
                                    ).format(_startDate!),
                                style: TextStyle(
                                  color:
                                      _startDate == null
                                          ? Colors.grey
                                          : (themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                               ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => setState(() => _startDate = null),
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                color:
                                    themeProvider.isDarkMode
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color:
                                    themeProvider.isDarkMode
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color:
                    themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color:
                        themeProvider.isDarkMode
                            ? Colors.grey[200]!
                            : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'End date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _endDate == null
                                    ? 'mm/dd/yyyy'
                                    : DateFormat(
                                      'MM/dd/yyyy',
                                    ).format(_endDate!),
                                style: TextStyle(
                                  color:
                                      _endDate == null
                                          ? Colors.grey
                                          : (themeProvider.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => setState(() => _endDate = null),
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                color:
                                    themeProvider.isDarkMode
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color:
                                    themeProvider.isDarkMode
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color:
                    themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color:
                        themeProvider.isDarkMode
                            ? Colors.grey[200]!
                            : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.book, color: Colors.grey[650], size: 20.0),
                          const SizedBox(width: 8.0),
                          const Text(
                            'Number of Pages Read',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _numberOfPagesController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.all(8.0),
                            border: InputBorder.none,
                            hintText: 'Enter number of pages read',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color:
                    themeProvider.isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color:
                        themeProvider.isDarkMode
                            ? Colors.grey[200]!
                            : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.grey[650], size: 20.0),
                          const SizedBox(width: 8.0),
                          const Text(
                            'Notes',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _statusController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintMaxLines: 1,
                            contentPadding: EdgeInsets.all(8.0),
                            border: InputBorder.none,
                            hintText: 'Add your notes here',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _statusController.dispose();
    _numberOfPagesController.dispose();
    super.dispose();
  }
}