import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/views/screens/main_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  final BookOperation bookOperation = BookOperation();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());

  runApp(BookTrailApp(bookOperation: bookOperation));
}

class BookTrailApp extends StatelessWidget {
  final BookOperation bookOperation;
  const BookTrailApp({super.key, required this.bookOperation});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          final userProvider = Provider.of<UserProvider>(context);

          return FutureBuilder(
            future: Hive.openBox<Book>(kBookBox(userProvider.userId!)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                );
              } else {
                return MaterialApp(
                  title: 'Book Trail',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(brightness: Brightness.light),
                  darkTheme: ThemeData(brightness: Brightness.dark),
                  themeMode:
                      themeProvider.isDarkMode
                          ? ThemeMode.dark
                          : ThemeMode.light,
                  home: MainView(bookOperation: bookOperation),
                );
              }
            },
          );
        },
      ),
    );
  }
}
