import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  Box<bool>? _themeBox;

  ThemeProvider() {
    _loadThemeState();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _loadThemeState() async {
    _themeBox = await Hive.openBox<bool>('themeBox');
    _isDarkMode = _themeBox?.get('darkMode') ?? WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _themeBox?.put('darkMode', _isDarkMode);
    notifyListeners();
  }
}