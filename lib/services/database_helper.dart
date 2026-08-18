import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/song.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('songs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE songs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  number TEXT NOT NULL,
  title TEXT NOT NULL,
  language TEXT NOT NULL,
  lyrics TEXT NOT NULL
)
''');

    // Seed the database from the JSON assets
    await _seedDatabase(db);
  }

  Future<void> _seedDatabase(Database db) async {
    try {
      final String response = await rootBundle.loadString('assets/songs.json');
      final List<dynamic> data = json.decode(response);

      Batch batch = db.batch();
      for (var songJson in data) {
        batch.insert('songs', {
          'number': songJson['number']?.toString() ?? '',
          'title': songJson['title']?.toString() ?? '',
          'language': songJson['language']?.toString() ?? 'fr',
          'lyrics': songJson['lyrics']?.toString() ?? '',
        });
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print('Error seeding database: $e');
    }
  }

  Future<List<Song>> getAllSongs() async {
    final db = await instance.database;
    final result = await db.query('songs', orderBy: 'CAST(number AS INTEGER) ASC');
    return result.map((json) => Song.fromMap(json)).toList();
  }

  Future<List<Song>> searchSongs(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'songs',
      where: 'title LIKE ? OR number LIKE ? OR lyrics LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'CAST(number AS INTEGER) ASC',
    );
    return result.map((json) => Song.fromMap(json)).toList();
  }

  Future<int> insertSong(Song song) async {
    final db = await instance.database;
    return await db.insert('songs', song.toMap());
  }

  Future<int> updateSong(Song song) async {
    final db = await instance.database;
    return await db.update(
      'songs',
      song.toMap(),
      where: 'id = ?',
      whereArgs: [song.id],
    );
  }

  Future<int> deleteSong(int id) async {
    final db = await instance.database;
    return await db.delete(
      'songs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
