import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;

  const CustomTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: "All"),
          Tab(text: "Read"),
          Tab(text: "Want to read"),
          Tab(text: "Reading"),
        ],
      ),
    );
  }
}
