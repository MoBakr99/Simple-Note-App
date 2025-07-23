import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../models/note.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChange;
  const HomeScreen(
      {super.key, required this.themeMode, required this.onThemeChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> _selectedNoteKeys = {};
  bool _isSelectionMode = false;

  void _toggleSelection(int key) {
    setState(() {
      if (_selectedNoteKeys.contains(key)) {
        _selectedNoteKeys.remove(key);
      } else {
        _selectedNoteKeys.add(key);
      }
      _isSelectionMode = _selectedNoteKeys.isNotEmpty;
    });
  }

  void _pinSelectedNotes() async {
    final box = Hive.box<Note>('notes');
    for (final key in _selectedNoteKeys) {
      final note = box.get(key);
      if (note != null) {
        note.isPinned = !note.isPinned;
        await note.save();
      }
    }
    _cancelSelection();
  }

  void _deleteSelectedNotes() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notes'),
        content:
            const Text('Are you sure you want to delete the selected notes?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final box = Hive.box<Note>('notes');
      for (final key in _selectedNoteKeys) {
        await box.delete(key);
      }
      _cancelSelection();
    }
  }

  void _cancelSelection() {
    setState(() {
      _selectedNoteKeys.clear();
      _isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Box<Note> noteBox = Hive.box<Note>('notes');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(
              widget.themeMode == ThemeMode.system
                  ? Icons.brightness_6
                  : widget.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
            ),
            onSelected: widget.onThemeChange,
            tooltip: 'Theme',
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    Icon(Icons.brightness_6),
                    SizedBox(width: 10),
                    Text('System')
                  ],
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(Icons.light_mode),
                    SizedBox(width: 10),
                    Text('Light')
                  ],
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(Icons.dark_mode),
                    SizedBox(width: 10),
                    Text('Dark')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box<Note> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("There's no notes."));
          }

          final notes = box.values.toList();
          notes.sort((a, b) {
            if (a.isPinned && !b.isPinned) return -1;
            if (!a.isPinned && b.isPinned) return 1;
            return b.date.compareTo(a.date);
          });

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final isSelected = _selectedNoteKeys.contains(note.key);
              return ListTile(
                leading: _isSelectionMode
                    ? Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined)
                    : null,
                title: Row(
                  children: [
                    if (note.isPinned) const Icon(Icons.push_pin, size: 16),
                    if (note.isPinned) const SizedBox(width: 4),
                    Text(note.title),
                  ],
                ),
                subtitle: Text(note.content,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: Text(
                    (DateTime.now().difference(note.date).inHours < 24)
                        ? DateFormat('h:mm a').format(note.date)
                        : note.date.toLocal().toString().split(' ')[0]),
                onTap: () {
                  if (_isSelectionMode) {
                    _toggleSelection(note.key as int);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetailScreen(noteKey: note.key),
                      ),
                    );
                  }
                },
                onLongPress: () => _toggleSelection(note.key as int),
              );
            },
          );
        },
      ),
      floatingActionButton: !_isSelectionMode
          ? FloatingActionButton(
              heroTag: 'addNoteBtn',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddNoteScreen()),
              ),
              tooltip: 'Add Note',
              shape: const CircleBorder(),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'pinBtn',
                    onPressed: _pinSelectedNotes,
                    tooltip: 'Pin',
                    shape: const CircleBorder(),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.push_pin),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: 'deleteBtn',
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    onPressed: _deleteSelectedNotes,
                    tooltip: 'Delete',
                    shape: const CircleBorder(),
                    child: const Icon(Icons.delete),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: 'cancelBtn',
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    onPressed: _cancelSelection,
                    tooltip: 'Cancel',
                    shape: const CircleBorder(),
                    child: const Icon(Icons.cancel_outlined),
                  ),
                ],
              ),
            ),
    );
  }
}
