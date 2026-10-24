import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'faibit_database.dart';
import 'sqlite_quiz_history_migrator.dart';
import 'sqlite_quiz_history_repository.dart';

class SqliteQuizHistoryProvider {
  const SqliteQuizHistoryProvider._({
    required this.database,
    required this.repository,
    required this.ownsDatabase,
  });

  static SqliteQuizHistoryProvider? _active;
  static Future<SqliteQuizHistoryProvider>? _initialization;

  final Database database;
  final SqliteQuizHistoryRepository repository;
  final bool ownsDatabase;

  static SqliteQuizHistoryProvider get active {
    final provider = _active;
    if (provider == null) {
      throw StateError('SQLite riwayat belum diinisialisasi.');
    }
    return provider;
  }

  static bool get isInitialized => _active != null;

  static Future<SqliteQuizHistoryProvider> initialize({
    required SharedPreferences preferences,
    Database? database,
  }) async {
    final active = _active;
    if (active != null) return active;

    final pending = _initialization;
    if (pending != null) return pending;

    final initialization = _initialize(
      preferences: preferences,
      database: database,
    );
    _initialization = initialization;
    try {
      return await initialization;
    } finally {
      if (identical(_initialization, initialization)) {
        _initialization = null;
      }
    }
  }

  static Future<SqliteQuizHistoryProvider> _initialize({
    required SharedPreferences preferences,
    required Database? database,
  }) async {
    final ownsDatabase = database == null;
    final openedDatabase = database ?? await FaibitDatabase.open();
    final repository = SqliteQuizHistoryRepository(openedDatabase);

    try {
      await SqliteQuizHistoryMigrator(
        preferences: preferences,
        repository: repository,
      ).migrate();
      final provider = SqliteQuizHistoryProvider._(
        database: openedDatabase,
        repository: repository,
        ownsDatabase: ownsDatabase,
      );
      _active = provider;
      return provider;
    } catch (_) {
      if (ownsDatabase) {
        await openedDatabase.close();
      }
      rethrow;
    }
  }

  static Future<void> dispose() async {
    if (_initialization != null) {
      throw StateError('SQLite riwayat sedang diinisialisasi.');
    }
    final active = _active;
    _active = null;
    if (active != null && active.ownsDatabase) {
      await active.database.close();
    }
  }
}
