import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/widgets/main_view_body.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  final BookOperation bookOperation;

  const MainView({super.key, required this.bookOperation,});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MainViewBody(bookOperation: widget.bookOperation));
  }
}