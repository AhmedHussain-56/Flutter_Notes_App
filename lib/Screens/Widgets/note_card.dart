import 'package:flutter/material.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Screens/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.index,
    required this.onDeleted,
  });

  final Note note;
  final int index;
  final Function(int) onDeleted;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                NoteView(note: note, index: index, onDeleted: onDeleted),
          ),
        );
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontFamily: 'Poppins',

                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                note.body,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black54,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
