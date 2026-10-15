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

class QuizQuestionResult {
  const QuizQuestionResult({
    required this.question,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.explanation,
  });

  final String question;
  final String selectedAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final String explanation;

  Map<String, dynamic> toJson() => {
    'question': question,
    'selectedAnswer': selectedAnswer,
    'correctAnswer': correctAnswer,
    'isCorrect': isCorrect,
    'explanation': explanation,
  };

  factory QuizQuestionResult.fromJson(Map<String, dynamic> json) =>
      QuizQuestionResult(
        question: json['question'] as String? ?? '',
        selectedAnswer: json['selectedAnswer'] as String? ?? '',
        correctAnswer: json['correctAnswer'] as String? ?? '',
        isCorrect: json['isCorrect'] as bool? ?? false,
        explanation: json['explanation'] as String? ?? '',
      );
}

class QuizAttempt {
  const QuizAttempt({
    required this.id,
    required this.completedAt,
    required this.type,
    required this.material,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.score,
    required this.durationSeconds,
    required this.questions,
  });

  final String id;
  final DateTime completedAt;
  final String type;
  final String material;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int score;
  final int durationSeconds;
  final List<QuizQuestionResult> questions;

  Map<String, dynamic> toJson() => {
    'id': id,
    'completedAt': completedAt.toIso8601String(),
    'type': type,
    'material': material,
    'totalQuestions': totalQuestions,
    'correctAnswers': correctAnswers,
    'incorrectAnswers': incorrectAnswers,
    'score': score,
    'durationSeconds': durationSeconds,
    'questions': questions.map((question) => question.toJson()).toList(),
  };

  factory QuizAttempt.fromJson(Map<String, dynamic> json) => QuizAttempt(
    id: json['id'] as String? ?? '',
    completedAt:
        DateTime.tryParse(json['completedAt'] as String? ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    type: json['type'] as String? ?? 'Latihan Santai',
    material: json['material'] as String? ?? '',
    totalQuestions: json['totalQuestions'] as int? ?? 0,
    correctAnswers: json['correctAnswers'] as int? ?? 0,
    incorrectAnswers: json['incorrectAnswers'] as int? ?? 0,
    score: json['score'] as int? ?? 0,
    durationSeconds: json['durationSeconds'] as int? ?? 0,
    questions: (json['questions'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(QuizQuestionResult.fromJson)
        .toList(),
  );
}
