import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/events.dart';
import 'package:news_app/globles.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.newspaper,
            color: Colors.black,
          ),
          label: topStoriesSection,
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book_outlined,
            color: Colors.grey,
          ),
          label: booksSection,
          activeIcon: Icon(
            Icons.book,
            color: Colors.black,
          ),
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.movie_creation_outlined,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            Icons.movie,
            color: Colors.black,
          ),
          label: moviesSection,
          backgroundColor: Colors.grey,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          switch (_selectedIndex) {
            case 0:
              eventBus.fire(BottomNavItemClickedEvent(Section.topStories));
              break;
            case 1:
              eventBus.fire(BottomNavItemClickedEvent(Section.books));
              break;
            case 3:
              eventBus.fire(BottomNavItemClickedEvent(Section.movies));
              break;
          }
        });
      },
    );
  }
}
