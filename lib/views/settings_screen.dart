import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.isDarkMode ? Colors.white : Colors.black;
    Color secondaryTextColor = widget.isDarkMode ? Colors.white70 : Colors.grey[800]!;
    Color cardColor = widget.isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;
    Color iconColor = widget.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username
            Card(
              elevation: 4.0,
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Username:', style: TextStyle(fontSize: 16, color: textColor)),
                    Text('', style: TextStyle(fontSize: 16, color: secondaryTextColor)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // Email
            Card(
              elevation: 4.0,
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email:', style: TextStyle(fontSize: 16, color: textColor)),
                    Text('', style: TextStyle(fontSize: 16, color: secondaryTextColor)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // Dark Mode
            Card(
              elevation: 4.0,
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dark_mode, color: iconColor),
                        SizedBox(width: 10),
                        Text('Dark mode', style: TextStyle(fontSize: 16, color: textColor)),
                      ],
                    ),
                    Switch(
                      value: widget.isDarkMode,
                      onChanged: (value) {
                        widget.toggleTheme(value);
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // Notifications
            Card(
              elevation: 4.0,
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notifications', style: TextStyle(fontSize: 16, color: textColor)),
                    Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // Language
            Card(
              elevation: 4.0,
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Language:', style: TextStyle(fontSize: 16, color: textColor)),
                    Text('English', style: TextStyle(fontSize: 16, color: secondaryTextColor)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Change Password Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[800],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),

            // Delete Data Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[800],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Delete Data',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}