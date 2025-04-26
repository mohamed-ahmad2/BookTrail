import 'package:flutter/material.dart';
import 'package:book_trail/widgets/home_favorite/custom_appbar.dart';
import 'package:book_trail/widgets/home_favorite/custom_navigation_bar.dart';
import 'package:book_trail/widgets/home_favorite/custom_tabbar.dart';
import 'package:book_trail/views/home_screen.dart';
import 'package:book_trail/views/favorites_screen.dart';
import 'package:book_trail/views/stats_screen.dart';
import 'package:book_trail/views/search_screen.dart';
import 'package:book_trail/views/settings_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

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

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoritesScreen(),
    StatsScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0 || index == 1) {
        _tabController = TabController(length: 4, vsync: this);
      }
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

    return Scaffold(
      appBar: CustomAppBar(title: _titles[_currentIndex]),
      body: Column(
        children: [
          if (showTabs) CustomTabBar(tabController: _tabController),
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
