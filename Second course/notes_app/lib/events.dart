import 'package:notes_app/note.dart';

class DeleteNoteEvent {
  final Note note;
  DeleteNoteEvent(this.note);
}

class DarkModeEvent {
  final bool isDarkMode;
  DarkModeEvent(this.isDarkMode);
}

class DeleteAllNotesEvent {
  DeleteAllNotesEvent();
}

class EditNoteEvent {
  final int index;
  final int lineIndex;
  EditNoteEvent(this.index, this.lineIndex);
}