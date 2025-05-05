import 'package:book_trail/book_operation.dart';
import 'package:book_trail/views/screens/favorites_screen.dart';
import 'package:book_trail/views/screens/home_screen.dart';
import 'package:book_trail/views/screens/search_screen.dart';
import 'package:book_trail/views/screens/settings_screen.dart';
import 'package:book_trail/views/screens/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_trail/views/widgets/home_favorite/custom_appbar.dart';
import 'package:book_trail/views/widgets/home_favorite/custom_navigation_bar.dart';
import 'package:book_trail/views/widgets/home_favorite/custom_tabbar.dart';

class MainLayout extends StatefulWidget {
  final BookOperation bookOperation;
  const MainLayout({super.key, required this.bookOperation});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  final List<String> _titles = [
    "Home",
    "Favorites",
    "Stats",
    "Search",
    "Settings",
  ];

  // final List<Widget> _screens = const [];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showTabs = _currentIndex == 0 || _currentIndex == 1;

    final List<Widget> screens = [
      HomeScreen(
        tabController: _tabController,
        bookOperation: widget.bookOperation,
      ),
      FavoritesScreen(tabController: _tabController),
      const StatsScreen(totalPages: 50000, numberOfPages: 20389),
      SearchScreen(bookOperation: widget.bookOperation),
      SettingsScreen(bookOperation: widget.bookOperation),
    ];

    return Scaffold(
      appBar: CustomAppBar(title: _titles[_currentIndex]),
      body: Column(
        children: [
          if (showTabs) CustomTabBar(tabController: _tabController),
          Expanded(child: screens[_currentIndex]),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
