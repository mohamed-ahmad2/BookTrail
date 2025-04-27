import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({super.key});

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  final TextEditingController _statusController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _readingStatus;
  int _rating = 0;

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Card(
                elevation: 4.0,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        // the image of the book will be here
                        height: 150,
                        width: 150,
                        color: Colors.grey[300],
                        child: Stack(),
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name book',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Author: ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Classification:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),

              // Summary label
              Card(
                elevation: 4.0,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summary book',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Summary text field
                        Text(
                          "it will be a text just for display the summary of the book",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              // Rating
              Card(
                elevation: 4.0,
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // عنوان Rating مظلل
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Rating',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // النجوم
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
                              setState(() {
                                _rating = index + 1;
                              });
                            },
                          );
                        }),
                      ),
                      SizedBox(height: 8.0),
                      Center(
                        child: Text(
                          'Selected Rating: $_rating/5',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),

              SizedBox(height: 8),
              Card(
                elevation: 4.0,
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Reading Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Read
                      Row(
                        children: [
                          Icon(Icons.done, color: Colors.grey[650]),
                          SizedBox(width: 8.0),
                          Expanded(child: Text('read')),
                          Radio<String>(
                            value: 'read',
                            groupValue: _readingStatus,
                            onChanged: (value) {
                              setState(() {
                                _readingStatus = value!;
                              });
                            },
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.black;
                              }
                              return Colors.grey;
                            }),
                          ),
                        ],
                      ),
                      // Reading
                      Row(
                        children: [
                          Icon(Icons.book, color: Colors.grey[650]),
                          SizedBox(width: 8.0),
                          Expanded(child: Text('reading')),
                          Radio<String>(
                            value: 'reading',
                            groupValue: _readingStatus,
                            onChanged: (value) {
                              setState(() {
                                _readingStatus = value!;
                              });
                            },
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.black;
                              }
                              return Colors.grey;
                            }),
                          ),
                        ],
                      ),
                      // Want to Read
                      Row(
                        children: [
                          Icon(Icons.bookmark_border, color: Colors.grey[650]),
                          SizedBox(width: 8.0),
                          Expanded(child: Text('want to read')),
                          Radio<String>(
                            value: 'want to read',
                            groupValue: _readingStatus,
                            onChanged: (value) {
                              setState(() {
                                _readingStatus = value!;
                              });
                            },
                            activeColor: Colors.blue,
                            fillColor: WidgetStateProperty.resolveWith<Color>((
                              states,
                            ) {
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
              SizedBox(height: 8.0),
              // Start Date
              Card(
                elevation: 4.0,
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
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
                                          : Colors.black,
                                ),
                              ),
                              Icon(Icons.calendar_today, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _startDate = null;
                              });
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // End Date
              Card(
                elevation: 4.0,
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
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
                                          : Colors.black,
                                ),
                              ),
                              Icon(Icons.calendar_today, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _endDate = null;
                              });
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // Notes
              Card(
                elevation: 4.0,
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.grey[650], size: 20.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Notes',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _statusController,
                          maxLines: 4,
                          decoration: InputDecoration(
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
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
