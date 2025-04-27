import 'package:book_trail/views/widgets/main_view_body.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const MainView({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MainViewBody(isDarkMode: widget.isDarkMode,
          toggleTheme: widget.toggleTheme,));
  }
}