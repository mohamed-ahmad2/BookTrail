import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final TabController tabController;

  const FavoritesScreen({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Here is Favorites Screen - Tab index: ${tabController.index}',
      ),
    );
  }
}
