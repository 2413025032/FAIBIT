import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Menyimpan daftar materi yang sudah ditandai selesai di perangkat.
class MaterialProgressRepository {
  MaterialProgressRepository._();

  static const String _storageKey = 'completed_material_titles_v1';

  /// Berubah setiap kali status materi selesai diperbarui.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static Future<Set<String>> loadCompletedTitles() async {
    final preferences = await SharedPreferences.getInstance();
    final titles = preferences.getStringList(_storageKey) ?? const <String>[];
    return titles.map((title) => title.trim()).where((title) => title.isNotEmpty).toSet();
  }

  static Future<void> markCompleted(String title) async {
    final normalizedTitle = title.trim();
    if (normalizedTitle.isEmpty) {
      throw ArgumentError.value(title, 'title', 'Judul materi tidak boleh kosong.');
    }

    final preferences = await SharedPreferences.getInstance();
    final titles = (preferences.getStringList(_storageKey) ?? <String>[]).toSet();
    final wasAdded = titles.add(normalizedTitle);

    if (wasAdded) {
      final saved = await preferences.setStringList(_storageKey, titles.toList()..sort());
      if (!saved) {
        throw StateError('Progres materi gagal disimpan.');
      }
      revision.value++;
    }
  }
}
