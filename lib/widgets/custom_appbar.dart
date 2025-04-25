import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        title: Center(child: Text("Home")),
        leading: ImageIcon(AssetImage("images/Library_Logo.png")),
        actions: [ImageIcon(AssetImage("images/Book_Logo.png"))],
        bottom: TabBar(
          tabs: [
            Tab(text: "All"),
            Tab(text: "Read"),
            Tab(text: "Want to read"),
            Tab(text: "Reading"),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48);
}
