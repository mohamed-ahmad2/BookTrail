import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotificationProvider with ChangeNotifier {
  bool _notificationsEnabled = false;
  Timer? _timer;
  Box<bool>? _notificationBox;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final List<String> _motivationalQuotes = [
    "Keep pushing forward, you're doing amazing! 🚀",
    "Every page you read brings you closer to your goal! 📚",
    "You're unstoppable, keep up the great work! 💪",
    "Believe in yourself, you've got this! 🌟",
    "Your dedication is inspiring, keep going! 🔥",
    "Turn your dreams into reality, one step at a time! ✨",
    "Stay focused and conquer your goals! 🎯",
    "You're stronger than you know, keep shining! 💡",
    "Embrace the journey, you're making progress! 🛤️",
    "Keep reading, your mind is growing! 🌱",
  ];

  NotificationProvider() {
    _loadNotificationState();
  }

  bool get notificationsEnabled => _notificationsEnabled;

  Future<void> _loadNotificationState() async {
    _notificationBox = await Hive.openBox<bool>('notificationBox');
    _notificationsEnabled = _notificationBox?.get('enabled') ?? false;
    if (_notificationsEnabled) {
      _startTimer(null); // Context will be passed later if needed
    }
    notifyListeners();
  }

  void toggleNotifications(bool value, BuildContext context) {
    _notificationsEnabled = value;
    _notificationBox?.put('enabled', value);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (_notificationsEnabled) {
      _startTimer(context);
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            'Motivational messages enabled! 🎉',
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
          backgroundColor: isDarkMode ? Colors.blue[300] : Colors.blue[800],
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      _stopTimer();
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            'Motivational messages disabled. 😴',
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
          backgroundColor: isDarkMode ? Colors.blue[300] : Colors.blue[800],
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    notifyListeners();
  }

  void _startTimer(BuildContext? context) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _showMotivationalMessage(context);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _showMotivationalMessage(BuildContext? context) {
    final random = Random();
    final quote = _motivationalQuotes[random.nextInt(_motivationalQuotes.length)];
    if (_notificationsEnabled) {
      // Use context if available, otherwise rely on scaffoldMessengerKey
      final isDarkMode = context != null
          ? Theme.of(context).brightness == Brightness.dark
          : false; // Fallback to light mode if context is null
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            quote,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
          backgroundColor: isDarkMode ? Colors.green[300] : Colors.green[800],
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}