import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());

  runApp(const BookTrailApp());
}

class BookTrailApp extends StatelessWidget {
  const BookTrailApp({super.key});

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
                      themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  home: const MainView(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
