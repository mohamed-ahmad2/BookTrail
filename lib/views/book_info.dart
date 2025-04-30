import 'package:book_trail/models/book_info_data.g.dart';
import 'package:book_trail/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
 // Import the new model file

class BookInfo extends StatefulWidget {
  // Placeholder for book ID (you'll pass this when ready)
  final String bookId; // Add this to identify the book in Hive

  const BookInfo({super.key, required this.bookId});

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  final TextEditingController _statusController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _readingStatus;
  int _rating = 0;

  late Box<BookInfoData> _bookInfoBox; // Hive box for storing book info

  get image => null;

  @override
  void initState() {
    super.initState();
    _openHiveBox(); // Open the Hive box when the screen initializes
    _loadBookInfo(); // Load the book info from Hive
  }

  // Open the Hive box for storing book information
  Future<void> _openHiveBox() async {
    _bookInfoBox = await Hive.openBox<BookInfoData>('bookInfoBox');
  }

  // Load book information from Hive
  Future<void> _loadBookInfo() async {
    final bookData = _bookInfoBox.get(widget.bookId);
    if (bookData != null) {
      setState(() {
        _readingStatus = bookData.readingStatus;
        _rating = bookData.rating ?? 0;
        _startDate = bookData.startDate;
        _endDate = bookData.endDate;
        _statusController.text = bookData.notes ?? '';
      });
    }
  }

  // Save book information to Hive
  Future<void> _saveBookInfo() async {
    final bookData = BookInfoData(
      readingStatus: _readingStatus,
      rating: _rating,
      startDate: _startDate,
      endDate: _endDate,
      notes: _statusController.text,
    );
    await _bookInfoBox.put(widget.bookId, bookData);
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
      await _saveBookInfo(); // Save to Hive after updating
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Information'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveBookInfo, // Save to Hive when the user presses the save button
          ),
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
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Card(
                        elevation: 4.0,
                        color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: NetworkImage(''), // Placeholder for book image URL
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name book', // Placeholder for book title
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Author: ', // Placeholder for author name
                            style: TextStyle(
                              fontSize: 18,
                              color: themeProvider.isDarkMode ? Colors.grey[200] : Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Classification: ', // Placeholder for classification
                            style: TextStyle(
                              fontSize: 18,
                              color: themeProvider.isDarkMode ? Colors.grey[200] : Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 100,
                    width: double.infinity,
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
                          "it will be a text just for display the summary of the book", // Placeholder for summary
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? Colors.grey[200] : Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 4.0,
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
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
                            color: themeProvider.isDarkMode ? Colors.grey[900] : Colors.black,
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
                            onPressed: () async {
                              setState(() {
                                _rating = index + 1;
                              });
                              await _saveBookInfo(); // Save to Hive after updating
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 8.0),
                      Center(
                        child: Text(
                          'Selected Rating: $_rating/5',
                          style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 4.0,
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
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
                            color: themeProvider.isDarkMode ? Colors.grey[900] : Colors.black,
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
                            onChanged: (value) async {
                              setState(() {
                                _readingStatus = value!;
                              });
                              await _saveBookInfo(); // Save to Hive after updating
                            },
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.black;
                              }
                              return Colors.grey;
                            }),
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
                            onChanged: (value) async {
                              setState(() {
                                _readingStatus = value!;
                              });
                              await _saveBookInfo(); // Save to Hive after updating
                            },
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.black;
                              }
                              return Colors.grey;
                            }),
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
                            onChanged: (value) async {
                              setState(() {
                                _readingStatus = value!;
                              });
                              await _saveBookInfo(); // Save to Hive after updating
                            },
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.black;
                              }
                              return Colors.grey;
                            }),
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
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
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
                                    : DateFormat('MM/dd/yyyy').format(_startDate!),
                                style: TextStyle(
                                  color: _startDate == null ? Colors.grey : Colors.black,
                                ),
                              ),
                              const Icon(Icons.calendar_today, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                _startDate = null;
                              });
                              await _saveBookInfo(); // Save to Hive after updating
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                color: themeProvider.isDarkMode ? Colors.grey[200] : Colors.grey[800],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: themeProvider.isDarkMode ? Colors.grey[200] : Colors.grey[800],
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
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
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
                                    : DateFormat('MM/dd/yyyy').format(_endDate!),
                                style: TextStyle(
                                  color: _endDate == null ? Colors.grey : Colors.black,
                                ),
                              ),
                              const Icon(Icons.calendar_today, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                _endDate = null;
                              });
                              await _saveBookInfo(); // Save to Hive after updating
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                color: themeProvider.isDarkMode ? Colors.grey[200] : Colors.grey[800],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: themeProvider.isDarkMode ? Colors.grey[200] : Colors.grey[800],
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
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: themeProvider.isDarkMode ? Colors.grey[200]! : Colors.grey[800]!,
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
                          onChanged: (value) async {
                            await _saveBookInfo(); // Save to Hive after updating
                          },
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
    Hive.close(); // Close Hive boxes when the screen is disposed
    super.dispose();
  }
}