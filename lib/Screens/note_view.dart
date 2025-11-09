import 'package:flutter/material.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
    required this.note,
    required this.index,
    required this.onDeleted,
  });

  final Note note;
  final int index;
  final Function(int) onDeleted;

  // helper function to delete note from SharedPreferences
  Future<void> _deleteNoteFromStorage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList('notes') ?? [];

    if (index < notes.length) {
      notes.removeAt(index);
      await prefs.setStringList('notes', notes);
    }

    if (!context.mounted) return; // prevents context issues
    onDeleted(index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note View'),
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Delete Note'),
                    content: const Text(
                      'Are you sure you want to delete this note?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                        ),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(dialogContext).pop();
                          await _deleteNoteFromStorage(
                            context,
                          ); //  delete safely
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(note.body, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
