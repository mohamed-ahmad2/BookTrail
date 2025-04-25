import 'package:flutter/material.dart';

class CustomSearchBarSearch extends StatelessWidget {
  const CustomSearchBarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        onTap: () => debugPrint("Search now"),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFECE6F0),
          hintText: "search text",
          prefixIcon: Icon(Icons.search),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 17),
            child: Icon(Icons.qr_code_scanner),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
