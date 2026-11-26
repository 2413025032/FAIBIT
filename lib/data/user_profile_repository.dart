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
      final normalizedName = normalizeFullName(name);
      final storedNickname = json['nickname'];
      final firstName = normalizedName.split(' ').firstWhere(
        (part) => part.isNotEmpty,
        orElse: () => 'Pengguna',
      );
      final nicknameSource =
          storedNickname is String && storedNickname.trim().isNotEmpty
          ? storedNickname
          : firstName;
      return UserProfile(
        name: normalizedName,
        nickname: normalizeNickname(nicknameSource),
        schoolClass: normalizeUppercaseField(schoolClass),
        school: normalizeUppercaseField(school),
        photoPath: photoPath is String ? photoPath : null,
      );
    } on FormatException {
      throw const FormatException('Data profil pengguna tidak valid.');
    }
  }

  Future<void> clear() async {
    if (!preferences.containsKey(_storageKey)) return;
    final removed = await preferences.remove(_storageKey);
    if (!removed) {
      throw StateError('Data profil pengguna tidak dapat dihapus.');
    }
  }

  Future<void> save(UserProfile profile) async {
    final saved = await preferences.setString(
      _storageKey,
      jsonEncode({
        'name': normalizeFullName(profile.name),
        'nickname': normalizeNickname(
          profile.nickname.trim().isEmpty
              ? normalizeFullName(profile.name).split(' ').first
              : profile.nickname,
        ),
        'schoolClass': normalizeUppercaseField(profile.schoolClass),
        'school': normalizeUppercaseField(profile.school),
        'photoPath': profile.photoPath,
      }),
    );
    if (!saved) {
      throw StateError('Profil pengguna tidak dapat disimpan.');
    }
  }
}
