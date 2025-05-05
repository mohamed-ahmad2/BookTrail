import 'package:book_trail/book_operation.dart' show BookOperation;
import 'package:book_trail/views/widgets/body_screen.dart';
import 'package:flutter/material.dart';

class MainViewBody extends StatefulWidget {
    final BookOperation bookOperation;
  const MainViewBody({super.key, required this.bookOperation});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [BodyScreen(bookOperation: widget.bookOperation)],
      ),
    );
  }
}
