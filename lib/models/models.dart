class UserProfile {
  const UserProfile({
    required this.name,
    required this.schoolClass,
    required this.school,
    this.photoPath,
  });

  final String name;
  final String schoolClass;
  final String school;
  final String? photoPath;

  UserProfile copyWith({String? name, String? schoolClass, String? school}) =>
      UserProfile(
        name: name ?? this.name,
        schoolClass: schoolClass ?? this.schoolClass,
        school: school ?? this.school,
      );
}

class MaterialSection {
  const MaterialSection({
    required this.title,
    required this.content,
    this.example,
  });

  final String title;
  final String content;
  final String? example;
}

class LearningMaterial {
  const LearningMaterial(
    this.title,
    this.description,
    this.example, {
    this.sections = const [],
  });

  final String title;
  final String description;
  final String example;
  final List<MaterialSection> sections;
}

class Question {
  const Question(
    this.id,
    this.material,
    this.question,
    this.options,
    this.correct,
    this.explanation,
  );

  final String id, material, question, explanation;
  final List<String> options;
  final int correct;
}

class ActivityItem {
  const ActivityItem(this.type, this.title, this.detail, this.time);
  final String type, title, detail, time;
}
