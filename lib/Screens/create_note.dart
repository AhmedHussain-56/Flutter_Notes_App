import 'package:flutter/material.dart';
import 'package:notes_app/Models/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',

          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 20),
              decoration: const InputDecoration(
                hintText: 'Discription',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (titleController.text.isEmpty || bodyController.text.isEmpty) {
            return;
          }

          final newNote = Note(
            title: titleController.text,
            body: bodyController.text,
          );

          //  existing behavior
          widget.onNewNoteCreated(newNote);

          //  save this note permanently to SharedPreferences
          //await _saveNoteToStorage(newNote);
          if (!mounted) return;

          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
