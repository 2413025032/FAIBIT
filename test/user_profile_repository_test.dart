import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faibit/data/user_profile_repository.dart';
import 'package:faibit/models/models.dart';

void main() {
  test('profile remains available after repository reinitialization', () async {
    SharedPreferences.setMockInitialValues({});
    final firstPreferences = await SharedPreferences.getInstance();
    final firstRepository = UserProfileRepository(firstPreferences);
    const profile = UserProfile(
      name: 'Alya',
      schoolClass: 'X TJKT 1',
      school: 'SMK Negeri 1 Bandar Lampung',
    );

    await firstRepository.save(profile);

    final secondPreferences = await SharedPreferences.getInstance();
    final restored = await UserProfileRepository(secondPreferences).load();

    expect(restored?.name, profile.name);
    expect(restored?.schoolClass, profile.schoolClass);
    expect(restored?.school, profile.school);
  });
}
