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

  get image => null;

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
      appBar: AppBar(title: Text('Book Information')),
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
                        //here is the image of the book
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              'data:image/jpeg;base64,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',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
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
