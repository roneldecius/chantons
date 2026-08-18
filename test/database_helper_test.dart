import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:chantons/services/database_helper.dart';
import 'package:chantons/models/song.dart';

void main() {
  // Initialize SQLite FFI for unit/widget tests
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('DatabaseHelper CRUD Tests', () {
    test('Insert, Update, and Delete Song', () async {
      final dbHelper = DatabaseHelper.instance;

      // 1. Insert a new song
      final testSong = Song(
        number: '9999',
        title: 'Test Song Title',
        language: 'fr',
        lyrics: 'Test lyrics line 1\nTest lyrics line 2',
      );

      final insertId = await dbHelper.insertSong(testSong);
      expect(insertId, isNotNull);
      expect(insertId, isPositive);

      // Verify insertion by searching
      final searchedSongsBefore = await dbHelper.searchSongs('Test Song Title');
      expect(searchedSongsBefore.length, 1);
      final insertedSong = searchedSongsBefore.first;
      expect(insertedSong.id, insertId);
      expect(insertedSong.number, '9999');
      expect(insertedSong.title, 'Test Song Title');
      expect(insertedSong.lyrics, 'Test lyrics line 1\nTest lyrics line 2');
      expect(insertedSong.language, 'fr');

      // 2. Update the song
      final updatedSong = Song(
        id: insertId,
        number: '9999B',
        title: 'Updated Test Song Title',
        language: 'ht',
        lyrics: 'Updated lyrics line 1\nUpdated lyrics line 2',
      );

      final updateResult = await dbHelper.updateSong(updatedSong);
      expect(updateResult, 1); // 1 row affected

      // Verify update
      final searchedSongsAfter = await dbHelper.searchSongs('Updated Test Song Title');
      expect(searchedSongsAfter.length, 1);
      final verifiedUpdatedSong = searchedSongsAfter.first;
      expect(verifiedUpdatedSong.id, insertId);
      expect(verifiedUpdatedSong.number, '9999B');
      expect(verifiedUpdatedSong.title, 'Updated Test Song Title');
      expect(verifiedUpdatedSong.lyrics, 'Updated lyrics line 1\nUpdated lyrics line 2');
      expect(verifiedUpdatedSong.language, 'ht');

      // 3. Delete the song
      final deleteResult = await dbHelper.deleteSong(insertId);
      expect(deleteResult, 1); // 1 row affected

      // Verify deletion
      final searchedSongsFinal = await dbHelper.searchSongs('Updated Test Song Title');
      expect(searchedSongsFinal.isEmpty, true);
    });
  });
}
