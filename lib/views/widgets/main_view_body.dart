import 'package:book_trail/views/widgets/body_screen.dart';
import 'package:flutter/material.dart';

class MainViewBody extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;
  const MainViewBody({super.key ,required this.isDarkMode,
    required this.toggleTheme,});

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
            children: [
              BodyScreen(isDarkMode: widget.isDarkMode,
          toggleTheme: widget.toggleTheme,),
            ],
          ),
        );
  }
}