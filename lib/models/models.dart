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

class LearningMaterial {
  const LearningMaterial(this.title, this.description, this.example);
  final String title, description, example;
}

class Question {
  const Question(this.question, this.options, this.correct, this.explanation);
  final String question, explanation;
  final List<String> options;
  final int correct;
}

class ActivityItem {
  const ActivityItem(this.type, this.title, this.detail, this.time);
  final String type, title, detail, time;
}
