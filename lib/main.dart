import 'package:book_trail/models/book_info_data.g.dart';
import 'package:book_trail/views/main_view.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

// Ensure the adapter is imported

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookInfoDataAdapter()); 
  runApp(const BookTrailApp());
}

class BookTrailApp extends StatelessWidget {
  const BookTrailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Book Trail',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const MainView(),
          );
        },
      ),
    );
  }
}
