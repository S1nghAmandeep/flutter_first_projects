import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/edit.dart';
import 'package:notes_app/events.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/note.dart';
import 'package:notes_app/settings.dart';
import 'package:notes_app/storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.storage});
  final String title;
  final NoteStorage storage;

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    initializeNotesList();
    eventBus.on<DeleteNoteEvent>().listen((event) {
      deleteNote(event.note);
    });
    eventBus.on<EditNoteEvent>().listen((event) {
      editNote(event.index, event.lineIndex);
    });
  }

  void rebuild() {
    setState(() {
      initializeNotesList();
    });
  }

  Future<void> initializeNotesList() async {
    List<Note> notesFromFile = await widget.storage.readNotes();
    setState(() {
      notes = notesFromFile;
    });
  }

  Future<void> editNote(int index, int lineIndex) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => EditNoteScreen(
          noteIndex: index,
          lineIndex: lineIndex,
          storage: NoteStorage(),
        ),
      ),
    );
    rebuild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: YELLOW,
        foregroundColor: BLACK,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          PopupMenuButton(
            tooltip: MORE,
            initialValue: "",
            onSelected: (String item) {
              openSettingsScreen();
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem(
                value: SETTINGS,
                child: Text(SETTINGS),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const SizedBox(
              width: 750,
              child: SearchBar(
                leading: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = notes[index];
                  return ListTile(
                    title: item.buidTitle(context),
                    subtitle: item.buildSubtitle(context),
                    trailing: item.buildButton(context),
                  );
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: notes.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewNote();
        },
        tooltip: CREATE_NEW_NOTES,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> createNewNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => EditNoteScreen(
          noteIndex: -1,
          lineIndex: notes.length * NUMBER_OF_LINES_FOR_NOTE,
          storage: widget.storage,
        ),
      ),
    );
    rebuild();
  }

  Future<void> deleteNote(Note note) async {
    final file = await widget.storage.localFile;
    final List<String> lines = await file.readAsLines();
    for (var i = 0; i < NUMBER_OF_LINES_FOR_NOTE; i++) {
      lines.removeAt(note.lineIndex);
    }

    await file.writeAsString(lines.join('\n')).whenComplete(() => setState(() {
          rebuild();
        }));
  }

  Future<void> openSettingsScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const SettingsScreen()),
    );
    rebuild();
  }
}
