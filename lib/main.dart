import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/layout/main_layout.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/models/user.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/providers/username_provider.dart';
import 'package:book_trail/views/screens/_login.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  final BookOperation bookOperation = BookOperation();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BookAdapter());
  await Hive.openBox<User>('users');

  runApp(BookTrailApp(bookOperation: bookOperation));
}

class BookTrailApp extends StatelessWidget {
  final BookOperation bookOperation;
  const BookTrailApp({super.key, required this.bookOperation});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UsernameProvider()),
      ],
      child: Consumer2<UserProvider, ThemeProvider>(
        builder: (context, userProvider, themeProvider, _) {
          return MaterialApp(
            title: 'Book Trail',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            initialRoute: userProvider.userId == null ? '/login' : '/main',
            routes: {
              '/login': (context) => LoginScreen(bookOperation: bookOperation),
              '/main': (context) => FutureBuilder(
                    future: Hive.openBox<Book>(kBookBox(userProvider.userId!)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                          body: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return MainLayout(bookOperation: bookOperation);
                    },
                  ),
            },
          );
        },
      ),
    );
  }
}
