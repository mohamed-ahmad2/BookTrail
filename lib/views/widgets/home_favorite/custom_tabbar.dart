import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;

  const CustomTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface,
      child: TabBar(
        controller: tabController,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.unselectedWidgetColor,
        indicatorColor: theme.colorScheme.primary,
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
