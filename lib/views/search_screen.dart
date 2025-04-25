import 'package:book_trail/views/widgets/custom_app_bar_search.dart';
import 'package:book_trail/views/widgets/custom_search_bar_search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSearch(),
      body: CustomSearchBarSearch(),
    );
  }
}
