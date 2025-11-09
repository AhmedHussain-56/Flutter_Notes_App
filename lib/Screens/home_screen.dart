import 'package:flutter/material.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Screens/Widgets/note_card.dart';
import 'package:notes_app/Screens/create_note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = List.empty(growable: true);

  // Save notes
  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> noteStrings = notes
        .map((note) => jsonEncode(note.toJson()))
        .toList();
    await prefs.setStringList('notes', noteStrings);
  }

  // Load notes
  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? noteStrings = prefs.getStringList('notes');
    if (!mounted) return;
    if (noteStrings != null) {
      setState(() {
        notes = noteStrings.map((e) => Note.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 90,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: notes.isEmpty
              ? const Center(
                  child: Text(
                    'No Notes Yet 📝\nTap + to add your first note!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: NoteCard(
                        note: notes[index],
                        index: index,
                        onDeleted: onNoteDeleted,
                      ),
                    );
                  },
                ),
        ),
      ),

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF42A5F5),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF1976D2),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    CreateNote(onNewNoteCreated: onNoteCreated),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  void onNoteCreated(Note note) {
    notes.add(note);
    saveNotes();
    if (!mounted) return;
    setState(() {});
  }

  void onNoteDeleted(int index) {
    notes.removeAt(index);
    saveNotes();
    if (!mounted) return;
    setState(() {});
  }
}
