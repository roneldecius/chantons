import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../localization/app_localizations.dart';
import '../models/song.dart';
import '../services/database_helper.dart';
import 'settings_screen.dart';
import 'song_screen.dart';
import 'song_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Song> _songs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  Future<void> _loadSongs() async {
    final query = _searchController.text;
    final results = query.isEmpty 
        ? await DatabaseHelper.instance.getAllSongs()
        : await DatabaseHelper.instance.searchSongs(query);
    
    if (mounted) {
      setState(() {
        _songs = results;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final loc = AppLocalizations(settings.languageCode);

    // Filter by selected language
    final filteredSongs = _songs.where((song) => song.language == settings.languageCode).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.get('title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ).then((_) {
                // Refresh list in case language changed
                if (mounted) setState(() {});
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: loc.get('search'),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                filled: true,
              ),
              onChanged: (_) => _loadSongs(),
            ),
          ),
          Expanded(
            child: _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : filteredSongs.isEmpty
                    ? Center(
                        child: Text(
                          loc.get('no_results'),
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          final song = filteredSongs[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                            elevation: 1,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              leading: CircleAvatar(
                                radius: 25,
                                child: Text(song.number, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              title: Text(
                                song.title, 
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Text(
                                song.lyrics.split('\n').first,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SongScreen(song: song),
                                  ),
                                ).then((_) => _loadSongs());
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: loc.get('add_song'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SongEditScreen()),
          ).then((_) => _loadSongs());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
