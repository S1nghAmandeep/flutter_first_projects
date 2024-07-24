import 'package:flutter/material.dart';
import 'package:news_app/article_section.dart';
import 'package:news_app/books_section.dart';
import 'package:news_app/bottom_navigation_bar.dart';
// import 'package:news_app/constants.dart';
import 'package:news_app/events.dart';
import 'package:news_app/globles.dart';
import 'package:news_app/top_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget section = const TopStoriesSection();

  @override
  void initState() {
    super.initState();
    eventBus.on<BottomNavItemClickedEvent>().listen((event) {
      setState(() {
        switch (event.section) {
          case Section.topStories:
            section = const TopStoriesSection();
            break;
          case Section.books:
            section = const BooksSection();
            break;
          default:
            section = const TopStoriesSection();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TopNavBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: section,
      ),
    );
  }
}
