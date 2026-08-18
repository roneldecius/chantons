import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';
import '../providers/settings_provider.dart';
import '../localization/app_localizations.dart';
import '../services/database_helper.dart';
import 'song_edit_screen.dart';

class SongScreen extends StatefulWidget {
  final Song song;

  const SongScreen({super.key, required this.song});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late Song _song;
  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    _song = widget.song;
  }

  Future<void> _editSong() async {
    final updatedSong = await Navigator.push<Song?>(
      context,
      MaterialPageRoute(
        builder: (context) => SongEditScreen(song: _song),
      ),
    );

    if (updatedSong != null) {
      setState(() {
        _song = updatedSong;
        _isEdited = true;
      });
    }
  }

  Future<void> _deleteSong(AppLocalizations loc) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.get('delete_confirm')),
        content: Text(loc.get('delete_confirm_desc')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(loc.get('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(loc.get('delete')),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      if (_song.id != null) {
        await DatabaseHelper.instance.deleteSong(_song.id!);
        if (mounted) {
          Navigator.pop(context, true); // Pop back to home signaling deletion
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final loc = AppLocalizations(settings.languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_song.number} - ${_song.title}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editSong,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteSong(loc),
          ),
        ],
      ),
      body: SafeArea(
        child: PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop && _isEdited) {
              // Return true to home screen if the song was edited
              // Note: using Navigator.pop with result is standard, but PopScope helps
              // back button. We handle navigation pop directly, but we can pass result back.
            }
          },
          child: InteractiveViewer(
            minScale: 1.0,
            maxScale: 5.0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  _song.lyrics,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
      // If back button is pressed, we want to pop with true if edited
      floatingActionButton: _isEdited
          ? FloatingActionButton(
              mini: true,
              child: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, true),
            )
          : null,
    );
  }
}
