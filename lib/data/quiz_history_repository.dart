import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class QuizHistoryRepository {
  QuizHistoryRepository(this.preferences);

  static const _storageKey = 'quiz_attempts_v1';
  static const practiceType = 'Latihan Santai';
  static const challengeType = 'Challenge';
  static late QuizHistoryRepository instance;
  static QuizHistoryRepository? _configured;
  final SharedPreferences preferences;

  static void configure(SharedPreferences preferences) {
    _configured = QuizHistoryRepository(preferences);
    instance = _configured!;
  }

  static Future<List<QuizAttempt>> loadStoredAttempts() async {
    if (_configured != null) return _configured!.loadAttempts();
    return [];
  }

  Future<List<QuizAttempt>> loadAttempts() async {
    final raw = preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return [];
      final attempts = decoded
          .whereType<Map<String, dynamic>>()
          .map(QuizAttempt.fromJson)
          .where((attempt) => attempt.id.isNotEmpty)
          .toList();
      attempts.sort((a, b) => b.completedAt.compareTo(a.completedAt));
      return attempts;
    } on FormatException {
      throw const FormatException('Data riwayat kuis tidak valid.');
    }
  }

  Future<void> saveAttempt(QuizAttempt attempt) async {
    final attempts = await loadAttempts();
    if (attempts.any((stored) => stored.id == attempt.id)) return;
    attempts.insert(0, attempt);
    final saved = await preferences.setString(
      _storageKey,
      jsonEncode(attempts.map((item) => item.toJson()).toList()),
    );
    if (!saved) {
      throw StateError('Riwayat kuis tidak dapat disimpan.');
    }
  }
}
