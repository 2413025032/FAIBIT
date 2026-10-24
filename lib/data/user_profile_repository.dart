import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class UserProfileRepository {
  UserProfileRepository(this.preferences);

  static const _storageKey = 'user_profile_v1';
  final SharedPreferences preferences;

  static late UserProfileRepository instance;

  static void configure(UserProfileRepository repository) {
    instance = repository;
  }

  Future<UserProfile?> load() async {
    final raw = preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) return null;

    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;
      final name = json['name'];
      final schoolClass = json['schoolClass'];
      final school = json['school'];
      if (name is! String ||
          schoolClass is! String ||
          school is! String ||
          name.isEmpty ||
          schoolClass.isEmpty ||
          school.isEmpty) {
        return null;
      }
      final photoPath = json['photoPath'];
      return UserProfile(
        name: name,
        schoolClass: schoolClass,
        school: school,
        photoPath: photoPath is String ? photoPath : null,
      );
    } on FormatException {
      throw const FormatException('Data profil pengguna tidak valid.');
    }
  }

  Future<void> save(UserProfile profile) async {
    final saved = await preferences.setString(
      _storageKey,
      jsonEncode({
        'name': profile.name,
        'schoolClass': profile.schoolClass,
        'school': profile.school,
        'photoPath': profile.photoPath,
      }),
    );
    if (!saved) {
      throw StateError('Profil pengguna tidak dapat disimpan.');
    }
  }
}
