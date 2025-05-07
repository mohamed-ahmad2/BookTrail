import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest_10y.dart' as tz show initializeTimeZones;
import 'package:timezone/timezone.dart' as tz;

class NotificationProvider with ChangeNotifier {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  bool _notificationsEnabled = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  NotificationProvider() {
    _initializeNotifications();
  }

  bool get notificationsEnabled => _notificationsEnabled;

  Future<void> _initializeNotifications() async {
    tz.initializeTimeZones();

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    // Combine platform-specific settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    // Initialize the plugin
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permissions for Android 13+
    if (await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.areNotificationsEnabled() ==
        false) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }

    // Load notification state from Hive
    await _loadNotificationState();
  }

  Future<void> _loadNotificationState() async {
    var box = await Hive.openBox<bool>('notificationBox');
    _notificationsEnabled =
        box.get('notificationsEnabled', defaultValue: false)!;
    notifyListeners();

    // If notifications are enabled, schedule them
    if (_notificationsEnabled) {
      await _scheduleNotification();
    }
  }

  Future<void> _saveNotificationState() async {
    var box = await Hive.openBox<bool>('notificationBox');
    await box.put('notificationsEnabled', _notificationsEnabled);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? channelId = 'book_trail_channel',
    String? channelName = 'Book Trail',
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'celebration_channel',
          'Celebration Notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> toggleNotifications(bool value, BuildContext context) async {
    _notificationsEnabled = value;
    await _saveNotificationState();
    notifyListeners();

    if (_notificationsEnabled) {
      await _scheduleNotification();
    } else {
      await _cancelNotifications();
    }
  }

  Future<void> _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'book_trail_channel',
          'Book Trail',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // List of motivational messages
    final List<String> messages = [
      '“A reader lives a thousand lives before he dies.” – George R.R. Martin',
      '“The more that you read, the more things you will know.” – Dr. Seuss',
      '“Reading is essential for those who seek to rise above the ordinary.” – Jim Rohn',
      '“Books are a uniquely portable magic.” – Stephen King',
      '“Until I feared I would lose it, I never loved to read. One does not love breathing.” – Harper Lee',
      '“Reading gives us someplace to go when we have to stay where we are.” – Mason Cooley',
      '“Once you learn to read, you will be forever free.” – Frederick Douglass',
      '“A room without books is like a body without a soul.” – Marcus Tullius Cicero',
      '“That’s the thing about books. They let you travel without moving your feet.” – Jhumpa Lahiri',
      'Keep going! Each page you read is a step toward growth.',
      'Stay motivated! Your future self will thank you for reading today.',
      'Reading is your daily investment in a better you. Don’t stop now!',
    ];

    var now = tz.TZDateTime.now(tz.local);
    for (int i = 0; i < 12; i++) {
      // Schedule notifications every 5 minutes
      var scheduledDate = now.add(Duration(minutes: 5 * i));

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        i, // Each notification should have a unique ID
        'Book Trail Reminder',
        messages[i % messages.length], // Rotate through the messages
        scheduledDate,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents:
            DateTimeComponents.time, // Optional: for daily repeat at same time
      );
    }

    // Show confirmation message
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Notification scheduled for 5 minutes from now.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _cancelNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();

    // Show confirmation message
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Notifications canceled.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
