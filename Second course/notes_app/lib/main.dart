import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/storage.dart';
import 'package:notes_app/events.dart';

void main() {
  runApp(MyApp(
    storage: NoteStorage(),
  ));
}

EventBus eventBus = EventBus();

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.storage});
  final NoteStorage storage;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    eventBus.on<DarkModeEvent>().listen((event) {
      if (event.isDarkMode) {
        changeTheme(ThemeMode.dark);
      } else {
        changeTheme(ThemeMode.light);
      }
    });
    eventBus.on<DeleteAllNotesEvent>().listen((event) {
      setState(() {
        deleteAllNotes();
      });
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void deleteAllNotes() async {
    await widget.storage.deleteAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      darkTheme: DARK,
      theme: LIGHT,
      home: MyHomePage(
        title: NOTES,
        storage: widget.storage,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}