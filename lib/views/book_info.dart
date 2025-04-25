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
              Container(
                // the image of the book will be here
                height: 150,
                width: 150,
                color: Colors.grey[300],
                child: Stack(),
              ),
              SizedBox(height: 16),
              // Book name
              Text(
                'Name book',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Author
              Text(
                'Author: ',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              // Summary label
              Text(
                'Summary book',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Summary text field
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  hintText: 'Enter summary here...',
                ),
              ),
              SizedBox(height: 16),
              
              // Rating
              Row(
                children: [
                  Text(
                    'Rating: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) =>
                          Icon(Icons.star, color: Colors.yellow[700], size: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Reading Status:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            // Read
            Row(
              children: [
                Radio<String>(
                  value: 'read',
                  groupValue: _readingStatus,
                  onChanged: (value) {
                    setState(() {
                      _readingStatus = value!;
                    });
                  },
                ),
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8.0),
                Text('read'),
              ],
            ),
            // Reading
            Row(
              children: [
                Radio<String>(
                  value: 'reading',
                  groupValue: _readingStatus,
                  onChanged: (value) {
                    setState(() {
                      _readingStatus = value!;
                    });
                  },
                ),
                Icon(Icons.bookmark, color: Colors.blue),
                SizedBox(width: 8.0),
                Text('reading'),
              ],
            ),
            // Want to Read
            Row(
              children: [
                Radio<String>(
                  value: 'want to read',
                  groupValue: _readingStatus,
                  onChanged: (value) {
                    setState(() {
                      _readingStatus = value!;
                    });
                  },
                ),
                Icon(Icons.favorite, color: const Color.fromARGB(255, 55, 57, 57)),
                SizedBox(width: 8.0),
                Text('want to read'),
              ],
            ),
            SizedBox(height: 16.0),
              SizedBox(height: 20.0),

              Text('Start date', style: TextStyle(fontWeight: FontWeight.bold)),
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
                            : DateFormat('MM/dd/yyyy').format(_startDate!),
                        style: TextStyle(
                          color:
                              _startDate == null ? Colors.grey : Colors.black,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('End date', style: TextStyle(fontWeight: FontWeight.bold)),
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
                            : DateFormat('MM/dd/yyyy').format(_endDate!),
                        style: TextStyle(
                          color: _endDate == null ? Colors.grey : Colors.black,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
