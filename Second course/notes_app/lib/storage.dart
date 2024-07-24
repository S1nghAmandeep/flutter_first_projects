import 'dart:convert';
import 'dart:io';

import 'package:notes_app/constants.dart';
import 'package:notes_app/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteStorage {
  int numberOfNotes = 0;

  Future<String> get _localPath async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
    return File('$path/notes.txt');
  }

  Future<File> writeNote(String title, String description, String lastEdited) async {
    final file = await localFile;
    String contents = title + "\n" + description + "\n" + lastEdited + "\n";
    return file.writeAsString(contents, mode: FileMode.append);
  }

  Future<List<Note>> readNotes() async {
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      LineSplitter lineSplitter = const LineSplitter();
      List<String> lines = lineSplitter.convert(contents);
      List<Note> notes = [];
      int indexCounter = 0;

      for (var i = 0; i < lines.length; i += NUMBER_OF_LINES_FOR_NOTE) {
        Note note = Note(lines[i], lines[i + 1], DateTime.parse(lines[i + 2]),
            i, indexCounter);
        notes.add(note);
        indexCounter++;
      }

      return notes;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<File> deleteAllNotes () async {
    final file = await localFile;
    return file.writeAsString("", mode: FileMode.write);
  }

  Future<Note> getNoteAtIndex(int index) async {
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      LineSplitter lineSplitter = const LineSplitter();
      List<String> lines = lineSplitter.convert(contents);
      List<Note> notes = [];

      for (var i = 0; i < lines.length; i += NUMBER_OF_LINES_FOR_NOTE) {
        Note note = Note(lines[i], lines[i + 1], DateTime.parse(lines[i + 2]), i, index);
        notes.add(note);
      }
      return notes[index];
    } catch (e) {
      print(e);
      return Note(NEW_NOTE_TITLE, NEW_NOTE_BODY, DateTime.now(), numberOfNotes * NUMBER_OF_LINES_FOR_NOTE, index);
    }
  }

  Future<File> overwriteNoteAtIndex(String title, String description, String lastEdited, int index, int lineIndex) async {
    final file = await localFile;
    final contents = await file.readAsString();
    LineSplitter lineSplitter = const LineSplitter();
    List<String> lines = lineSplitter.convert(contents);
    String firstLine = title;
    String secondLine = description;
    String thirdLine = lastEdited;
    lines[lineIndex] = firstLine;
    lines[lineIndex + 1] = secondLine;
    lines[lineIndex + 2] = thirdLine;
    String result = lines.join("\n") + "\n";
    return file.writeAsString(result, mode: FileMode.write);
  }
}
