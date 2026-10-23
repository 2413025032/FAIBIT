import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class FaibitDatabase {
  const FaibitDatabase._();

  static const databaseName = 'faibit.db';
  static const databaseVersion = 1;

  static Future<Database> open() async {
    final databasePath = path.join(await getDatabasesPath(), databaseName);
    return openDatabase(
      databasePath,
      version: databaseVersion,
      onConfigure: _configure,
      onCreate: (database, version) => createSchema(database),
    );
  }

  static Future<void> _configure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> createSchema(Database database) async {
    await database.execute('''
      CREATE TABLE quiz_attempts (
        id TEXT PRIMARY KEY,
        completed_at TEXT NOT NULL,
        type TEXT NOT NULL,
        material TEXT NOT NULL,
        total_questions INTEGER NOT NULL,
        correct_answers INTEGER NOT NULL,
        incorrect_answers INTEGER NOT NULL,
        score INTEGER NOT NULL,
        duration_seconds INTEGER NOT NULL
      )
    ''');
    await database.execute('''
      CREATE TABLE quiz_question_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        attempt_id TEXT NOT NULL,
        question_index INTEGER NOT NULL,
        question TEXT NOT NULL,
        selected_answer TEXT NOT NULL,
        correct_answer TEXT NOT NULL,
        is_correct INTEGER NOT NULL,
        explanation TEXT NOT NULL,
        FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id)
          ON DELETE CASCADE,
        UNIQUE (attempt_id, question_index)
      )
    ''');
  }
}
