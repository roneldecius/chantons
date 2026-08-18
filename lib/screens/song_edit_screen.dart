import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../localization/app_localizations.dart';
import '../models/song.dart';
import '../services/database_helper.dart';

class SongEditScreen extends StatefulWidget {
  final Song? song;

  const SongEditScreen({super.key, this.song});

  @override
  State<SongEditScreen> createState() => _SongEditScreenState();
}

class _SongEditScreenState extends State<SongEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _numberController;
  late TextEditingController _titleController;
  late TextEditingController _lyricsController;
  late String _selectedLanguage;

  bool get _isEditing => widget.song != null;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(text: widget.song?.number ?? '');
    _titleController = TextEditingController(text: widget.song?.title ?? '');
    _lyricsController = TextEditingController(text: widget.song?.lyrics ?? '');
    
    // Set default language based on the settings provider or the song if editing
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    _selectedLanguage = widget.song?.language ?? settings.languageCode;
  }

  @override
  void dispose() {
    _numberController.dispose();
    _titleController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  Future<void> _saveSong(AppLocalizations loc) async {
    if (!_formKey.currentState!.validate()) return;

    final song = Song(
      id: widget.song?.id,
      number: _numberController.text.trim(),
      title: _titleController.text.trim(),
      language: _selectedLanguage,
      lyrics: _lyricsController.text.trim(),
    );

    if (_isEditing) {
      await DatabaseHelper.instance.updateSong(song);
    } else {
      await DatabaseHelper.instance.insertSong(song);
    }

    if (mounted) {
      Navigator.pop(context, song);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final loc = AppLocalizations(settings.languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? loc.get('edit_song') : loc.get('add_song')),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _saveSong(loc),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              // Song Number field
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: loc.get('song_number'),
                  prefixIcon: const Icon(Icons.numbers),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.get('number_required');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: loc.get('song_title'),
                  prefixIcon: const Icon(Icons.title),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.get('title_required');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Language selection dropdown
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: InputDecoration(
                  labelText: loc.get('song_language'),
                  prefixIcon: const Icon(Icons.language),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'fr',
                    child: Text(loc.get('french')),
                  ),
                  DropdownMenuItem(
                    value: 'ht',
                    child: Text(loc.get('creole')),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Lyrics field
              TextFormField(
                controller: _lyricsController,
                maxLines: 12,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: loc.get('song_lyrics'),
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.get('lyrics_required');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Save button
              ElevatedButton(
                onPressed: () => _saveSong(loc),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  loc.get('save'),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
