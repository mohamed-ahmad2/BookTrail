import 'package:book_trail/models/user.dart';
import 'package:book_trail/views/_login.dart';
import 'package:book_trail/views/_register.dart';
import 'package:book_trail/views/home_screen.dart';
import 'package:book_trail/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  runApp(const BookTrailApp());
}

class BookTrailApp extends StatelessWidget {
  const BookTrailApp({super.key});
  
  get tabController => null;

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
            initialRoute: '/',
            routes: {
              '/': (context) => const MainView(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const Register(),
              '/mainLayout': (context) => HomeScreen(tabController: tabController,)
            },
          );
        },
      ),
    );
  }
}
