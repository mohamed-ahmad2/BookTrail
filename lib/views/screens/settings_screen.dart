import 'package:book_trail/book_operation.dart';
import 'package:book_trail/providers/notification_provider.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/username_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/models/user.dart';
import 'package:book_trail/views/screens/_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends StatefulWidget {
  final BookOperation bookOperation;
  const SettingsScreen({super.key, required this.bookOperation});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _email;
  String? _username;

  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user data when the screen initializes
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final usernameProvider = Provider.of<UsernameProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Get username from UsernameProvider or userId from UserProvider
    _username = usernameProvider.username ?? userProvider.userId;
    
    if (_username != null) {
      var box = await Hive.openBox<User>('users');
      User? user = box.values.firstWhere(
        (user) => user.username == _username,
        orElse: () => User(username: '', password: '', email: ''),
      );

      if (user.username.isNotEmpty && mounted) {
        setState(() {
          _email = user.email;
          _username = user.username; // Ensure username is set
        });
        // Update UsernameProvider if it was null
        if (usernameProvider.username == null) {
          usernameProvider.setUsername(user.username);
        }
      }
    }
  }

  Future<void> _updatePassword() async {
    if (_username != null) {
      var box = await Hive.openBox<User>('users');
      User? user = box.values.firstWhere(
        (user) => user.username == _username,
        orElse: () => User(username: '', password: '', email: ''),
      );

      if (user.username.isNotEmpty) {
        if (user.password == _passwordController.text.trim() &&
            _newPasswordController.text.trim() ==
                _confirmPasswordController.text.trim()) {
          user.password = _newPasswordController.text.trim();
          await user.save();
          final notificationProvider = Provider.of<NotificationProvider>(
            context,
            listen: false,
          );
          notificationProvider.scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Password updated successfully'),
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.of(context).pop();
          _passwordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        } else if (user.password != _passwordController.text.trim()) {
          final notificationProvider = Provider.of<NotificationProvider>(
            context,
            listen: false,
          );
          notificationProvider.scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Incorrect current password'),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          final notificationProvider = Provider.of<NotificationProvider>(
            context,
            listen: false,
          );
          notificationProvider.scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('New passwords do not match'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _passwordController.clear();
                _newPasswordController.clear();
                _confirmPasswordController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _updatePassword,
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {

    // Clear userId from authBox
    var authBox = Hive.box<String>('authBox');
    await authBox.delete('userId');

    // Check if widget is still mounted before using context
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(bookOperation: widget.bookOperation),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      // Removed key: notificationProvider.scaffoldMessengerKey to avoid GlobalKey conflict
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Username
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Username:', style: TextStyle(fontSize: 16)),
                      Text(
                        _username ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Email
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Email:', style: TextStyle(fontSize: 16)),
                      Text(_email ?? '', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Dark Mode
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.dark_mode),
                          SizedBox(width: 10),
                          Text('Dark mode', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleDarkMode();
                        },
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Notifications
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(fontSize: 16),
                      ),
                      Switch(
                        value: notificationProvider.notificationsEnabled,
                        onChanged: (value) async {
                          try {
                            await notificationProvider.toggleNotifications(
                              value,
                              context,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to toggle notifications: $e',
                                ),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Language
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Language:', style: TextStyle(fontSize: 16)),
                      Text('English', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Change Password Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showChangePasswordDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // LogOut
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'LogOut',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}