import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/note.dart';
import 'package:notes_app/storage.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen(
      {super.key, required this.noteIndex, required this.lineIndex, required this.storage});

  final int noteIndex;
  final int lineIndex;
  final NoteStorage storage;

  @override
  State<EditNoteScreen> createState() {
    return _EditNoteScreenState();
  }
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descEditingController = TextEditingController();
  bool isNewNote = false;
  int index = -1;
  int lineIndex = -1;
  String titleText = "";

  @override
  void initState() {
    super.initState();
    index = widget.noteIndex;
    lineIndex = widget.lineIndex;
    isNewNote = index == -1;
    titleText = isNewNote ? CREATE_NEW_NOTES : EDIT_NOTE;
    if (isNewNote) {
      titleEditingController.text = NEW_NOTE_TITLE;
      descEditingController.text = NEW_NOTE_BODY;
    } else {
      loadNoteToEdit();
    }
  }

  void loadNoteToEdit() async {
    Note note = await widget.storage.getNoteAtIndex(widget.noteIndex);
    setState(() {
      titleEditingController.text = note.title;
      descEditingController.text = note.body;
    });
  }

  void navigateToHomeScreen() {
    Navigator.pop(context);
  }

  void deleteNote() {
    navigateToHomeScreen();
  }

  void saveNote() async {
    String lastEditedDate = DateTime.now().toString();
    index = widget.noteIndex;
    if(index == -1) {
      await widget.storage.writeNote(titleEditingController.text, descEditingController.text, lastEditedDate);
    } else {
      await widget.storage.overwriteNoteAtIndex(titleEditingController.text, descEditingController.text, lastEditedDate, index, lineIndex);
    }
    List<Note> notes = await widget.storage.readNotes();
    notes.forEach((element) => print(element.title + " " + element.body + " " + element.lastEdited.toString() ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: YELLOW,
        foregroundColor: BLACK,
        title: Text(
          titleText,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: BLACK),
        ),
        actions: [
          IconButton(
            onPressed: () {
              saveNote();
            },
            icon: const Icon(Icons.save),
            tooltip: SAVE,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            tooltip: DELETE,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 650,
              child: TextField(
                controller: titleEditingController,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              width: 650,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descEditingController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
