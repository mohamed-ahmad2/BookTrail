import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/layout/main_layout.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/models/user.dart';
import 'package:book_trail/providers/notification_provider.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/providers/username_provider.dart';
import 'package:book_trail/views/screens/_login.dart';
import 'package:book_trail/views/widgets/body_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  final BookOperation bookOperation = BookOperation();
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BookAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<bool>('notificationBox');
  await Hive.openBox<bool>('themeBox');
  await Hive.openBox<String>('authBox');

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await requestNotificationPermission();

  runApp(BookTrailApp(bookOperation: bookOperation));
}

Future<void> requestNotificationPermission() async {
  try {
    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  } catch (e) {
    debugPrint('Notification permission error: $e');
  }
}

class BookTrailApp extends StatelessWidget {
  final BookOperation bookOperation;
  const BookTrailApp({super.key, required this.bookOperation});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final userProvider = UserProvider();
            final authBox = Hive.box<String>('authBox');
            final userId = authBox.get('userId');
            if (userId != null) {
              userProvider.setUserId(userId);
            }
            return userProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final usernameProvider = UsernameProvider();
            final authBox = Hive.box<String>('authBox');
            final userId = authBox.get('userId');
            if (userId != null) {
              usernameProvider.setUsername(userId); // Username is same as userId
            }
            return usernameProvider;
          },
        ),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: Consumer2<UserProvider, ThemeProvider>(
        builder: (context, userProvider, themeProvider, _) {
          final notificationProvider = Provider.of<NotificationProvider>(
            context,
            listen: false,
          );
          return MaterialApp(
            title: 'Book Trail',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: Brightness.light),
            darkTheme: ThemeData(brightness: Brightness.dark),
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            builder: (context, child) {
              return ScaffoldMessenger(
                key: notificationProvider.scaffoldMessengerKey,
                child: child!,
              );
            },
            initialRoute: '/body', // Set BodyScreen as initial route
            routes: {
              '/body': (context) => BodyScreen(bookOperation: bookOperation),
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