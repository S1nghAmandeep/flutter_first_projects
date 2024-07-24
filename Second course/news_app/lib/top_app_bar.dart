import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  State<TopNavBar> createState() => _TopNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(topAppBarHeight);
}

class _TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      flexibleSpace: Image.asset(nyTimesLogoImage),
    );
  }
}
