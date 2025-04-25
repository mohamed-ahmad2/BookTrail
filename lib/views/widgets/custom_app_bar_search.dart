import 'package:flutter/material.dart';

class CustomAppBarSearch extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(252, 233, 254, 1),
      centerTitle: true,
      title: Text("Search"),
      leading: Image.asset("images/Library_Logo.png"),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Image.asset("images/Book_Logo.png"),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
