import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/events.dart';
import 'package:notes_app/main.dart';

enum NoteOption { edit, delete }

class Note {
  final String title;
  final String body;
  final DateTime lastEdited;
  int lineIndex;
  int index;
  late PopupMenuButton button;
  NoteOption? selectedNoteoption;

  Note(this.title, this.body, this.lastEdited, this.lineIndex, this.index);
  Widget buidTitle(BuildContext context) => Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  Widget buildSubtitle(BuildContext context) => Text.rich(TextSpan(children: [
        TextSpan(text: body),
        TextSpan(
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
          text: "\n" +
              "Last edited: " +
              DateFormat('yyyy-MM-dd | hh:mm:ss').format(lastEdited),
        )
      ]));

  Widget buildButton(BuildContext context) => PopupMenuButton<NoteOption>(
        initialValue: selectedNoteoption,
        onSelected: (NoteOption item) {
          selectedNoteoption = item;
          if (selectedNoteoption == NoteOption.edit) {
            eventBus.fire(EditNoteEvent(index, lineIndex));
          } else if (selectedNoteoption == NoteOption.delete) {
            eventBus.fire(DeleteNoteEvent(this));
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<NoteOption>>[
          const PopupMenuItem<NoteOption>(
              value: NoteOption.edit, child: Text(EDIT)),
          const PopupMenuItem<NoteOption>(
              value: NoteOption.delete, child: Text(DELETE)),
        ],
      );
}
